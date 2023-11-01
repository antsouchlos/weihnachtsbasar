import typing

from tinydb import TinyDB, Query
import os


# =================================
# ======== Database layout ========
# =================================
#
# {
#     shifts: ["Freitag...", ...],
#     accounts: [
#         {
#             "username": "abcd",
#             "password_hash": "efgh",
#             "permissions": ["Stand0", "Stand1", ...],
#         },
#         {
#             "username": "abcd",
#             "password_hash": "efgh",
#             "permissions": ["Stand0", "Stand1", ...],
#         },
#         ...
#     ],
#     registration_status: {
#         "Stand0": {
#             "0": true,
#             "1": false,
#             ...
#         },
#         "Stand1": {
#             "0": true,
#             "1": false,
#             ...
#         },
#         ...
#     },
#     standdata: {
#         "Stand0": {
#             "0": [
#                 {"Name": "Max Mustermann", ...},
#                 {"Name": "Max Mustermann", ...},
#                 ...
#             ]
#             "1": [
#                 {"Name": "Max Mustermann", ...},
#                 {"Name": "Max Mustermann", ...},
#                 ...
#             ],
#             ...
#         },
#         "Stand1": {
#             "0": [
#                 {"Name": "Max Mustermann", ...},
#                 {"Name": "Max Mustermann", ...},
#                 ...
#             ]
#             "1": [
#                 {"Name": "Max Mustermann", ...},
#                 {"Name": "Max Mustermann", ...},
#                 ...
#             ],
#             ...
#         },
#     }
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

    # Registration stuff

    # TODO: Check whether a user with that email already exists
    #  for that stand and that shift
    def register(self, name: str, email: str, phone: str, stand: str,
                 shift: int):
        """Register a new helper."""
        pass

    def remove_registration(self, stand: str, shift: int, email: str):
        # TODO
        pass

    # Shift stuff

    def add_shift(self, text_de: str, text_gr: str):
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
        shift_table = self._db.table("shifts")

        Shift = Query()
        print(f"[DEBUG] shift_id: {shift_id}")
        if len(shift_table.search(Shift.shift_id == shift_id)) == 0:
            raise Exception("An exception with this ID does not exist")

        shift_table.remove(Shift.shift_id == shift_id)

    def get_shifts(self) -> typing.List[typing.Tuple[int, str, str]]:
        """Get a list of all shifts."""
        shift_table = self._db.table("shifts")

        result = []
        for shift in shift_table.all():
            result.append(
                (int(shift["shift_id"]), shift["text_de"], shift["text_gr"]))

        return result

    # Misc

    def get_stand_data(self, stand: str) -> typing.Dict:
        """Get list of registered helpers for a stand."""
        pass

    def set_registration_status(self, stand: str, shift: int, status: bool):
        """Enable / Disable registration for a given shift of a given stand."""
        # TODO
        pass