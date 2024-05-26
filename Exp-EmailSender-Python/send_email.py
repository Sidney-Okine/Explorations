import smtplib
from email.message import EmailMessage

email = EmailMessage()
email['from'] = "Sidney Okine"
email['to'] = 'sidneytokine@gmail.com'
email['subject'] = 'TEST EMAIL FROM SMTP'

email.set_content('I am Sidney !!')

with smtplib.SMTP(host='smtp.gmail.com', port=587) as smtp:
    smtp.ehlo()
    smtp.starttls()
    smtp.login('okinesidney1@gmail.com', 'yhmv cwqc ormc beoo')
    smtp.send_message(email)
