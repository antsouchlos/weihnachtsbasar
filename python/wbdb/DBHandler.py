import typing

from tinydb import TinyDB, Query
import tinydb
import os
from wbdb import utility
import json
import time


# =================================
# ======== Database layout ========
# =================================
#
# {
#     shifts: ["Freitag...", ...],
#     users: [
#         {
#             "email": "a@b.c",
#             "name": "asdf adsf",
#             "phone": "123456543",
#             "password_hash": "efgh",
#             "stand_slug": "stand0_slug",
#             "roles": ["Stand0", "Stand1", ...]
#         },
#         {
#             "username": "abcd",
#             "password_hash": "efgh",
#             "roles": ["efgh"]
#         },
#         ...
#     ],
#     registration_blacklist: {
#         {"stand_name"}: "stand_{stand0_slug}", "blacklist": []},
#         {"stand_name"}: "stand_{stand1_slug}", "blacklist": [0, 1]},
#         ...
#     },
#     "stand_{stand0_slug}": {
#         {"shift_id": 0, "name": "Max Mustermann", ...},
#         {"shift_id": 0, "name": "Max Mustermann", ...},
#         ...
#         {"shift_id": 1, "name": "Max Mustermann", ...},
#         {"shift_id": 1, "name": "Max Mustermann", ...},
#         ...
#     }
#     "stand_{stand1_slug}": {
#         {"shift_id": 0, "name": "Max Mustermann", ...},
#         {"shift_id": 0, "name": "Max Mustermann", ...},
#         ...
#         {"shift_id": 1, "name": "Max Mustermann", ...},
#         {"shift_id": 1, "name": "Max Mustermann", ...},
#         ...
#     },
#     ...
# }
#
#


# TODO: Only show data if authenticated
# TODO: Replace print statement with proper logging
# TODO: Don't do error handling of the normal program flow with exceptions
class DBHandler:
    """Class which handles database stuff."""

    def __init__(self, logger):
        self._db = TinyDB('{0}/db.json'.format(os.getcwd()))
        self._logger = logger

    # Utility

    @staticmethod
    def _get_stand_slug(standname_de):
        return f"stand_{utility.slugify(standname_de)}"

    def _stand_exists(self, slug: str) -> bool:
        """Check if a stand with a given name exists."""
        blacklist_table = self._db.table("registration_blacklist")

        Stand = Query()
        return len(blacklist_table.search(Stand.stand_slug == slug)) > 0

    def _get_stand_table(self, standname_de: str):
        """Get the table corresponding to a stand with a given name. If the
        stand in question does not exist, an exception is raised.
        """
        stand_slug = self._get_stand_slug(standname_de)

        if not self._stand_exists(stand_slug):
            raise Exception(f"Stand '{stand_slug}' does not exist")

        return self._db.table(stand_slug)

    # Registration stuff

    def _get_shift_id_by_text(self, text):
        """Get the id of a shift given its text."""
        shift_table = self._db.table("shifts")

        Shift = Query()

        results_de = None
        results_gr = None

        while True:
            try:
                results_de = shift_table.search(Shift.text_de == text)
                results_gr = shift_table.search(Shift.text_gr == text)
                break
            except json.decoder.JSONDecodeError as e:
                time.sleep(0.1)
                continue

        if len(results_de) > 0:
            return results_de[0]["shift_id"]
        elif len(results_gr) > 0:
            return results_gr[0]["shift_id"]
        else:
            raise Exception(f"A shift with this text does not exist: {text}")

    def _get_stand_slug_by_name(self, standname):
        """Get the slug of a stand given its name."""
        blacklist_table = self._db.table("registration_blacklist")

        results_de = None
        results_gr = None

        Stand = Query()
        while True:
            try:
                results_de = blacklist_table.search(Stand.standname_de == standname)
                results_gr = blacklist_table.search(Stand.standname_gr == standname)
                break
            except json.decoder.JSONDecodeError as e:
                time.sleep(0.1)
                continue

        if len(results_de) > 0:
            return results_de[0]["stand_slug"]
        elif len(results_gr) > 0:
            return results_gr[0]["stand_slug"]
        else:
            raise Exception(f"A stand with this name does not exist: {standname}")

    def add_registration(self, name, email, phone, standname, shift_text):
        """Add new registration."""
        shift_id = self._get_shift_id_by_text(shift_text)

        stand_slug = self._get_stand_slug_by_name(standname)
        stand_table = self._db.table(stand_slug)

        stand_table.insert({"shift_id": shift_id, "name": name, "email": email, "phone": phone})

    def remove_registration(self, standname: str, shift_text: int,
                            email: str):
        """Remove an existing registration."""
        shift_id = self._get_shift_id_by_text(shift_text)

        stand_slug = self._get_stand_slug_by_name(standname)
        stand_table = self._db.table(stand_slug)

        User = Query()
        if len(stand_table.search((User.email == email)
                                  & (User.shift_id == shift_id))) == 0:
            raise Exception(
                f"A user with the email {email} has not been registered "
                f"for shift {shift_id} of stand {stand_slug}")

        stand_table.remove((User.email == email)
                           & (User.shift_id == shift_id))

    def get_registrations(self, standname: str, shift_text: str):
        """Get a list of relevant registrations for a given stand and shift."""
        shift_id = self._get_shift_id_by_text(shift_text)

        stand_slug = self._get_stand_slug_by_name(standname)
        stand_table = self._db.table(stand_slug)

        Registration = Query()
        result = None

        while True:
            try:
                result = [{"name": reg['name'], "email": reg['email'], "phone": reg['phone']} for reg in stand_table.search(Registration.shift_id == shift_id)]
                break
            except json.decoder.JSONDecodeError as e:
                time.sleep(0.1)
                continue
        return result


    # Stand stuff

    def add_stand(self, standname_de: str, standname_gr: str):
        """Add a new stand. Creates the corresponding table as well as
        registration blacklist entry.
        """
        stand_slug = self._get_stand_slug(standname_de)
        if self._stand_exists(stand_slug):
            raise Exception(f"Table {stand_slug} already exists")

        blacklist_table = self._db.table("registration_blacklist")
        blacklist_table.insert(
            {"stand_slug": stand_slug, "standname_de": standname_de,
             "standname_gr": standname_gr, "blacklist": []})

    def remove_stand(self, stand_slug: str):
        """Remove and existing stand. Removes the corresponding table as well
        as the registration blacklist entry.
        """
        if not self._stand_exists(stand_slug):
            raise Exception(f"A table with the name {stand_slug} does "
                            f"not exist")

        self._db.drop_table(stand_slug)

        blacklist_table = self._db.table("registration_blacklist")
        Stand = Query()
        blacklist_table.remove(Stand.stand_slug == stand_slug)

    def get_stands(self):
        """Get a list of all existing stands."""
        blacklist_table = self._db.table("registration_blacklist")

        result = []
        for stand in blacklist_table.all():
            result.append({"stand_slug": stand["stand_slug"],
                           "standname_de": stand["standname_de"],
                           "standname_gr": stand["standname_gr"]})

        return result

    # Shift stuff

    def add_shift(self, text_de: str, text_gr: str):
        """Add a new shift."""
        shift_table = self._db.table("shifts")

        Shift = Query()
        if (len(shift_table.search(Shift["text_de"] == text_de)) > 0) or (
                shift_table.search(Shift["text_gr"] == text_gr)):
            raise Exception("A shift with this text already exists")

        shift_ids = [shift["shift_id"] for shift in shift_table.all()]
        new_shift_id = max(shift_ids) + 1 if len(shift_ids) > 0 else 0

        shift_table.insert(
            {"shift_id": new_shift_id, "text_de": text_de, "text_gr": text_gr})

    def remove_shift(self, shift_id: int):
        """Remove an existing shift."""
        shift_table = self._db.table("shifts")

        Shift = Query()
        if len(shift_table.search(Shift.shift_id == shift_id)) == 0:
            raise Exception("A shift with this ID does not exist")

        shift_table.remove(Shift.shift_id == shift_id)

        standnames = [stand["standname_de"] for stand in self.get_stands()]
        for standname in standnames:
            stand_table = self._get_stand_table(standname)
            Registration = Query()
            stand_table.remove(Registration.shift_id == shift_id)

    def get_shifts(self) -> typing.List[typing.Dict]:
        """Get a list of all shifts."""
        shift_table = self._db.table("shifts")

        result = []
        for shift in shift_table.all():
            result.append(
                {"shift_id": int(shift["shift_id"]),
                 "text_de": shift["text_de"], "text_gr": shift["text_gr"]})

        return result

    def _get_blacklist_for_stand(self, standname: str):
        """Return a list of the shift_ids of the blacklisted shifts for a given stand."""
        stand_slug = self._get_stand_slug_by_name(standname)

        blacklist_table = self._db.table("registration_blacklist")

        BlacklistEntry = Query()
        blacklist_entries = blacklist_table.search(BlacklistEntry.stand_slug == stand_slug)

        return blacklist_entries[0]["blacklist"]

    def get_shifts_for_stand(self, standname: str):
        """Get a list of shifts open for registration for a given stand."""
        shift_table = self._db.table("shifts")

        blacklist = self._get_blacklist_for_stand(standname)

        result = []
        for shift in shift_table.all():
            if shift["shift_id"] not in blacklist:
                result.append(
                    {"shift_id": int(shift["shift_id"]),
                     "text_de": shift["text_de"], "text_gr": shift["text_gr"]})

        return result

    # User management

    def add_user(self, name: str, email: str, phone: str, password_hash: str, standname: str):
        """Add a new user."""
        stand_slug = self._get_stand_slug_by_name(standname)
        roles = [stand_slug]

        user_table = self._db.table("users")

        User = Query()
        if len(user_table.search(User["email"] == email)) > 0:
            raise Exception(
                f"A user with the email {email} already exists")

        user_table.insert(
            {"name": name, "email": email, "phone": phone, "password_hash": password_hash, "stand_slug": stand_slug, "roles": roles})

    def remove_user(self, email: str):
        """Remove an existing user."""
        user_table = self._db.table("users")

        Shift = Query()
        if len(user_table.search(Shift.email == email)) == 0:
            raise Exception(
                f"A user with the email {email} does not exist")

        user_table.remove(Shift.email == email)

    def _get_standname_by_stand_slug(self, stand_slug: str):
        blacklist_table = self._db.table("registration_blacklist")

        Stand = Query()
        possible_stands = blacklist_table.search(Stand.stand_slug == stand_slug)

        if len(possible_stands) == 0:
            return "[Deleted Stand]"
        else:
            return possible_stands[0]["standname_de"]
        

    def get_users(self):
        """Return a list of all users with their usernames, password hashes
        and roles.
        """
        user_table = self._db.table("users")

        result = []
        for user in user_table.all():
            standname = self._get_standname_by_stand_slug(user["stand_slug"])
            result.append(
                {"email": user["email"],
                 "name": user["name"],
                 "phone": user["phone"],
                 "standname": standname,
                 "password_hash": user["password_hash"],
                 "roles": user["roles"]})

        return result

    # Misc

    def get_stand_data(self, stand_slug: str) -> typing.List[typing.Dict]:
        """Get list of registered helpers for a stand."""
        if not self._stand_exists(stand_slug):
            raise Exception(f"Stand '{stand_slug}' does not exist")
        
        stand_table = self._db.table(stand_slug)

        result = []

        shift_ids = [shift["shift_id"] for shift in self.get_shifts()]
        for shift_id in shift_ids:
            Registration = Query()
            registrations = stand_table.search(
                Registration.shift_id == shift_id)
            result.append(
                {"shift_id": shift_id, "registrations": registrations})

        return result

    def set_registration_status(self, standname: str, shift_text: str,
                                status: bool):
        """Enable / Disable registration for a given shift of a given stand."""
        stand_slug = self._get_stand_slug_by_name(standname)
        shift_id = self._get_shift_id_by_text(shift_text)

        blacklist_table = self._db.table("registration_blacklist")

        StandEntry = Query()
        blacklist = blacklist_table.search(StandEntry.stand_slug == stand_slug)[0]["blacklist"]

        if (shift_id in blacklist) and status:
            blacklist.remove(shift_id)
        elif (shift_id not in blacklist) and (not status):
            blacklist.append(shift_id)

        blacklist_table.update({"blacklist": blacklist}, StandEntry.stand_slug == stand_slug)

    def get_registration_status(self, standname: str, shift_text: str):
        """Get the current registration status (open / closed) for a shift of a given stand."""
        stand_slug = self._get_stand_slug_by_name(standname)
        shift_id = self._get_shift_id_by_text(shift_text)

        blacklist_table = self._db.table("registration_blacklist")

        StandEntry = Query()
        blacklist = blacklist_table.search(StandEntry.stand_slug == stand_slug)[0]["blacklist"]

        status = "closed" if shift_id in blacklist else "open"

        return {"status": status}

    def get_stand_for_user(self, email):

        blacklist_table = self._db.table("registration_blacklist")
        user_table = self._db.table("users")

        User = Query()
        users = user_table.search(User["email"] == email)
        if len(users) == 0:
            raise Exception(f"An error occurred while getting stand for user: A user with the email '{email}' does not exist")

        stand_slug = users[0]["stand_slug"]

        Stand = Query()
        stands = blacklist_table.search(Stand.stand_slug == stand_slug)
        if len(stands) == 0:
            raise Exception(f"An error occurred while getting stand for user: A stand with the slug '{stand_slug}' does not exist")
        stand = stands[0]


        result = {"stand_slug": stand["stand_slug"],
                  "standname_de": stand["standname_de"],
                  "standname_gr": stand["standname_gr"]}
        return result


    def get_responsible_for_stand(self, standname):
        stand_slug = self._get_stand_slug_by_name(standname)
        
        user_table = self._db.table("users")

        User = Query()
        users = user_table.search(User.stand_slug == stand_slug)

        if len(users) == 0:
            raise Exception(f"A user responsible for stand {stand_slug} could not be found")

        user = users[0]
        result = {"name": user["name"], "email": user["email"], "phone": user["phone"]}
        return result

