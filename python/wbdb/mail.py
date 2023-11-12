import smtplib
from email.mime.text import MIMEText

if __name__ == "__main__":
    from config import email_sender, email_password
else:
    from wbdb.config import email_sender, email_password

import argparse


def _send_email(subject, body, recipients):
    msg = MIMEText(body)

    msg['Subject'] = subject
    msg['From'] = email_sender
    msg['To'] = ', '.join(recipients)

    with smtplib.SMTP_SSL('smtp.gmail.com', 465) as smtp_server:
        smtp_server.login(email_sender, email_password)
        smtp_server.sendmail(email_sender, recipients, msg.as_string())


def send_helper_email(recipients, responsible_name, responsible_email,
                      responsible_phone, stand, language):
    subject = None
    body = None

    if language == "de":
        subject = "Anmeldung als Helfer beim Weihnachtsbasar"
        body = f"""Hallo,
        
Vielen Dank für Ihre Anmeldung als HelferIn am Stand \"{stand}\"!

Der/Die Verantwortliche für diesen Stand ist:

{responsible_name}
{responsible_email}
{responsible_phone}

Er/Sie wird in nächster Zeit Kontakt zu Ihnen aufnehmen, oder melden Sie sich bei dem/der Standverantwortlichen.

Elektronische Helferanmeldung
"""
    else:
        subject = "Εγγραφή ως βοηθός στο χριστουγεννιάτικο παζάρι"
        body = f"""Γεια σας,

Σας ευχαριστούμε για την εγγραφή σας ως βοηθός στον πάγκο \"{stand}\"!

Ο/Η υπεύθυνος για αυτόν τον πάγκο:

{responsible_name}
{responsible_email}
{responsible_phone}

Ο/Η υπεύθυνος Θα επικοινωνήσει μαζί σας τις επόμενες ημέρες.
Για περαιτέρω ερωτήσεις, παρακαλούμε μιλήστε με τον/την υπεύθυνο.

Ηλεκτρονική εγγραφή βοηθών
"""

    _send_email(subject, body, recipients)


def send_responsible_email(recipients, helper_name, helper_email, helper_phone,
                           stand, shift):
    subject = "Anmeldung eines Helfers für den Weihnachtsbasar"

    body = f"""Hallo,

Als HelferIn für Ihren Stand \"{stand}\" hat sich angemeldet:

{helper_name}
{helper_email}
{helper_phone}
Zeit: {shift}

Bitte nehmen Sie mit ihr/ihm Kontakt auf, um den Einsatz zu bestätigen und weitere Details abzusprechen.

Elektronische Helferanmeldung"""

    _send_email(subject, body, recipients)


#
# Command line interface for testing
#


def helper_func(args):
    recipients = [args.recipient]
    name = args.name
    email = args.email
    phone = args.phone
    stand = args.stand
    language = args.language

    send_helper_email(recipients, name, email, phone, stand, language)


def responsible_func(args):
    recipients = [args.recipient]
    name = args.name
    email = args.email
    phone = args.phone
    stand = args.stand
    shift = args.shift

    send_responsible_email(recipients, name, email, phone, stand, shift)


def main():
    parser = argparse.ArgumentParser(prog="email")
    subparsers = parser.add_subparsers()

    helper_parser = subparsers.add_parser("helper")
    helper_parser.set_defaults(func=helper_func)
    helper_parser.add_argument('--recipient', '-r', required=True,
                               help="Email of recipient")
    helper_parser.add_argument('--name', '-n', required=True,
                               help="Name of responsible")
    helper_parser.add_argument('--email', '-e', required=True,
                               help="Email of responsible")
    helper_parser.add_argument('--phone', '-p', required=True,
                               help="Phone of responsible")
    helper_parser.add_argument('--stand', '-s', required=True,
                               help="Standname")
    helper_parser.add_argument('--language', '-l', required=True,
                               help="Language of the email",
                               choices=["de", "gr"])

    responsible_parser = subparsers.add_parser("responsible")
    responsible_parser.set_defaults(func=responsible_func)
    responsible_parser.add_argument('--recipient', '-r', required=True,
                                    help="Email of recipient")
    responsible_parser.add_argument('--name', '-n', required=True,
                                    help="Name of responsible")
    responsible_parser.add_argument('--email', '-e', required=True,
                                    help="Email of responsible")
    responsible_parser.add_argument('--phone', '-p', required=True,
                                    help="Phone of responsible")
    responsible_parser.add_argument('--stand', '-s', required=True,
                                    help="Standname")
    responsible_parser.add_argument('--shift', '-t', required=True,
                                    help="Standname")

    args = parser.parse_args()
    if hasattr(args, "func"):
        args.func(args)


if __name__ == "__main__":
    main()
