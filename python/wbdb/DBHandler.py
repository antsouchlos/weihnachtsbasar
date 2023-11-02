import typing

from tinydb import TinyDB, Query
import tinydb
import os
from wbdb import utility


# =================================
# ======== Database layout ========
# =================================
#
# {
#     shifts: ["Freitag...", ...],
#     users: [
#         {
#             "username": "abcd",
#             "password_hash": "efgh",
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
        return len(blacklist_table.search(Stand.standname == slug)) > 0

    def _get_stand_table(self, standname_de: str):
        """Get the table corresponding to a stand with a given name. If the
        stand in question does not exist, an exception is raised.
        """
        stand_slug = self._get_stand_slug(standname_de)

        if not self._stand_exists(stand_slug):
            raise Exception(f"Stand '{stand_slug}' does not exist")

        return self._db.table(stand_slug)

    # Registration stuff

    def register(self, name: str, email: str, phone: str, standname_de: str,
                 shift_id: int):
        """Register a new helper."""
        stand_table = self._get_stand_table(standname_de)

        User = Query()
        if len(stand_table.search((User.email == email)
                                  & (User.shift_id == shift_id))) > 0:
            raise Exception(
                f"A user with the email {email} has already been registered "
                f"for shift {shift_id}")

        stand_table.insert({"shift_id": shift_id, "name": name, "email": email,
                            "phone": phone})

    def remove_registration(self, standname_de: str, shift_id: int,
                            email: str):
        """Remove an existing registration."""
        stand_table = self._get_stand_table(standname_de)

        User = Query()
        if len(stand_table.search((User.email == email)
                                  & (User.shift_id == shift_id))) == 0:
            raise Exception(
                f"A user with the email {email} has not been registered "
                f"for shift {shift_id}")

        stand_table.remove((User.email == email)
                           & (User.shift_id == shift_id))

    # Stand stuff

    def add_stand(self, standname_de: str, standname_gr: str):
        """Add a new stand. Creates the corresponding table as well as
        registration blacklist entry.
        """
        stand_slug = self._get_stand_slug(standname_de)
        if self._stand_exists(stand_slug):
            raise Exception(f"Table {stand_slug} already exists")

        stand_table = self._db.table(stand_slug)
        blacklist_table = self._db.table("registration_blacklist")
        blacklist_table.insert({"standname": stand_slug, "blacklist": []})

    def remove_stand(self, standname_de: str):
        """Remove and existing stand. Removes the corresponding table as well
        as the registration blacklist entry.
        """
        stand_slug = self._get_stand_slug(standname_de)
        if not self._stand_exists(stand_slug):
            raise Exception(f"A table with the name {stand_slug} does"
                            f"not exist")

        self._db.drop_table(stand_slug)

        blacklist_table = self._db.table("registration_blacklist")
        Stand = Query()
        blacklist_table.remove(Stand.stand_name == stand_slug)

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

    def get_shifts(self) -> typing.List[typing.Tuple[int, str, str]]:
        """Get a list of all shifts."""
        shift_table = self._db.table("shifts")

        result = []
        for shift in shift_table.all():
            result.append(
                (int(shift["shift_id"]), shift["text_de"], shift["text_gr"]))

        return result

    # User management

    def add_user(self, username: str, password_hash: str,
                 roles: typing.List[str]):
        """Add a new user."""
        user_table = self._db.table("users")

        User = Query()
        if len(user_table.search(User["username"] == username)) > 0:
            raise Exception(
                f"A user with the username {username} already exists")

        user_table.insert(
            {"username": username, "password_hash": password_hash,
             "roles": roles})

    def remove_user(self, username: str):
        """Remove an existing user."""
        user_table = self._db.table("users")

        Shift = Query()
        if len(user_table.search(Shift.username == username)) == 0:
            raise Exception(
                f"A user with the username {username} does not exist")

        user_table.remove(Shift.username == username)

    def get_users(self):
        """Return a list of all users with their usernames, password hashes
        and roles.
        """
        user_table = self._db.table("users")

        result = []
        for user in user_table.all():
            result.append(
                {"username": user["username"],
                 "password_hash": user["password_hash"],
                 "roles": user["roles"]})

        return result

    # Misc

    def get_stand_data(self, stand: str) -> typing.Dict:
        """Get list of registered helpers for a stand."""
        pass

    def set_registration_status(self, stand: str, shift: int,
                                status: bool):
        """Enable / Disable registration for a given shift of a given stand."""
        # TODO
        pass
