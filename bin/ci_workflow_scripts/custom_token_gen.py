# Copyright 2018 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from __future__ import print_function

import os
import sys
import uuid

import firebase_admin
from firebase_admin import auth
from firebase_admin import credentials

sys.path.append("lib")


# Snippets are taken from the official Firebase Admin SDK Python source:
# https://github.com/firebase/firebase-admin-python

def initialize_sdk_with_service_account():
    import firebase_admin
    from firebase_admin import credentials
    cred = credentials.Certificate('./serviceAcc.json')
    default_app = firebase_admin.initialize_app(cred)


def create_token_uid():
    cred = credentials.Certificate('./serviceAcc.json')
    default_app = firebase_admin.initialize_app(cred)
    uid = 'BE_TEST_' + str(uuid.uuid4())
    custom_token_from_uid = auth.create_custom_token(uid)
    return custom_token_from_uid

# generate custom token
custom_token = create_token_uid()

# put the token into backend test env file
with open("./assets/.env.backend_test", "a") as backend_env:
    backend_env.write("\nCUSTOM_TOKEN=" + custom_token.decode('utf-8'))

# remove FB serviceAcc file since it is not needed anymore
os.remove('./serviceAcc.json')
