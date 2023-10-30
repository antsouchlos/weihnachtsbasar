import typing

from tinydb import TinyDB, Query
import os
import logging


# TODO: Only show data if authenticated
class DBHandler:
    """Class which handles database stuff."""

    def __int__(self):
        self._db = TinyDB('{0}/db.json'.format(os.getcwd()))
        # self._db_logger = logging.getLogger("DBLogger")

    def register(self, name: str, email: str, phone: str, stand: str,
                 shift: str) -> None:
        """Register a new helper."""
        print(f"[DEBUG] Registering new helper: {name}, {email}, {phone}, "
              f"{stand}, {shift}")

    # TODO: Find out return type
    def get_stand_data(self, stand: str) -> typing.Dict:
        """Get list of registered helpers for a stand."""
        print(f"Fetching stand data for {stand}")
        return {"test": "test"}
