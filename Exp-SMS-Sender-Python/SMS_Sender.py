from twilio.rest import Client

account_sid = 'AC11a477b70f5c760a53f1969ec9fa73b0'
auth_token = '575fdc165e67df1ca2dce78d2a7a3011'
client = Client(account_sid, auth_token)

message = client.messages.create(
  from_='+13343264084',
  body='This is a test message from 2821LABS!!! We are coming',
  to='+233552012316'
)

print(message.sid)