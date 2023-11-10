from nest_theromostat import NestThermostat

thermostat = NestThermostat()
print(thermostat.query(query_type="devices"))

# Get tokens

import requests

access_token = "Redacted"
refresh_token = "Redacted"

project_id = 'dd5300be-467b-4f4a-ad65-84c22d6b91da'
client_id = '671502165349-aq0h48s56v60mqtb0b2evcjuf9fvfkuc.apps.googleusercontent.com'
client_secret = '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'
redirect_uri = 'https://nest.aymericballester.com'

## generate access

# params = (
#     ('client_id', client_id),
#     ('client_secret', client_secret),
#     ('refresh_token', refresh_token),
#     ('grant_type', 'refresh_token'),
# )

# response = requests.post('https://www.googleapis.com/oauth2/v4/token', params=params)

# response_json = response.json()
# access_token = response_json['token_type'] + ' ' + response_json['access_token']
# print('Access token: ' + access_token)

## show device list

url_get_devices = 'https://smartdevicemanagement.googleapis.com/v1/enterprises/' + project_id + '/devices'

headers = {
    'Content-Type': 'application/json',
    'Authorization': access_token,
}

response = requests.get(url_get_devices, headers=headers)

print(response.json())

response_json = response.json()
device_0_name = response_json['devices'][0]['name']
print(device_0_name)

# # url = 'https://nestservices.google.com/partnerconnections/'+project_id+'/auth?redirect_uri='+redirect_uri+'&access_type=offline&prompt=consent&client_id='+client_id+'&response_type=code&scope=https://www.googleapis.com/auth/sdm.service'
# # print("Go to this URL to log in:")
# # print(url)

# generate refresh token

# code = "Redacted"

# params = (
#     ('client_id', client_id),
#     ('client_secret', client_secret),
#     ('code', code),
#     ('grant_type', 'authorization_code'),
#     ('redirect_uri', redirect_uri),
# )

# response = requests.post('https://www.googleapis.com/oauth2/v4/token', params=params)

# response_json = response.json()
# access_token = response_json['token_type'] + ' ' + str(response_json['access_token'])
# print('Access token: ' + access_token)
# refresh_token = response_json['refresh_token']
# print('Refresh token: ' + refresh_token)

# url_structures = 'https://smartdevicemanagement.googleapis.com/v1/enterprises/' + project_id + '/structures'

# headers = {
#     'Content-Type': 'application/json',
#     'Authorization': access_token,
# }

# response = requests.get(url_structures, headers=headers)

# print(response.json())