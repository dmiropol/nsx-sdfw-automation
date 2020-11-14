#!/usr/bin/env python
# Copyright %d, Alex & Co, All Rights Reserved
import sys
import os
import json
import requests
from requests.auth import HTTPBasicAuth
import urllib3


class GoTo(Exception):
    def __init__(self, message='', errno=0):
        super(GoTo, self).__init__(message)
        self.message = message
        self.errno = errno


class mainObj():
    def __init__(self):
        configFile = 'env_profile.json'
        with open(configFile, 'r') as fp:
            self.mConfig = json.load(fp)
            self.nsxmgr = self.mConfig.get('env').get('nsxmgr')
            self.nsx_user = self.mConfig.get('env').get('nsx_user')
            self.nsx_password = self.mConfig.get('env').get('nsx_password')

            # print ('Using NSX Mgr URL: ', self.nsxmgr)

    def __str__(self):
        arr = ['{0} = {1}'.format(key, str(value)) for key, value in self.__dict__.iteritems()]
        return '\\n'.join(arr)

    def __del__(self):
        ' Destructor '
        pass

    def __enter__(self):
        return self

    def __exit__(self, etype, value, trcback):
        ' Clean Up'
        return False  # exception to be re-raised after exit

    def process(self, args):
        if len(args) <= 1:
            raise GoTo(message='json file or argument is missing', errno=1)

        self.connect()
        self.handle_request(args)

    def connect(self):
        urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
        url = self.nsxmgr + '/policy/api/v1/infra/'
        response = requests.get(url, verify=False, auth=HTTPBasicAuth(self.nsx_user, self.nsx_password))
        if response:
            #json_object = json.loads(response.text)
            print('Successfully connected to:', self.nsxmgr + '.')
            #print(json.dumps(json_object, indent=2))
        else:
            print(response.text)
            raise GoTo(message='Got Error connecting to: ' + url, errno=1)

    def handle_request(self, args):
        dfw_profile = args[0]
        operation = args[1]

        with open(dfw_profile, 'r') as fp:
            dfw_template = json.load(fp)
        if type(dfw_template) == dict:
            self.process_item(dfw_template, operation)
        else:
            raise GoTo(message='Invalid json file', errno=3)

    def process_item(self, dfw_template, operation):
        infra = '/policy/api/v1/infra'
        element = next(iter(dfw_template))
        for item in dfw_template.get(element):
            if type(item) == dict:
                id = item.get('id')
                if element == 'groups':
                    url = self.nsxmgr + infra + '/domains/default/groups/' + id
                elif element == 'services':
                    url = self.nsxmgr + infra + '/services/' + id
                elif element == 'firewall-security':
                    url = self.nsxmgr + infra + '/settings/firewall/' + id
                elif element == 'security-policies':
                    url = self.nsxmgr + infra + '/domains/default/security-policies/' + id
                elif element == 'ids-profiles':
                    url = self.nsxmgr + infra + '/settings/firewall/security/intrusion-services/profiles/' + id
                elif element == 'ids-rules':
                    url = self.nsxmgr + infra + '/domains/default/intrusion-service-policies/' + id
                else:
                    raise GoTo(message='Invalid json file', errno=3)

                self.send_request(operation, url, body=item)

    def send_request(self, operation, url, body):
        if operation == 'list':
            response = requests.get(url, verify=False, auth=HTTPBasicAuth(self.nsx_user, self.nsx_password))
        elif operation == 'create':
            response = requests.patch(url, verify=False, auth=HTTPBasicAuth(self.nsx_user, self.nsx_password),
                                      json=body)
        else:
            response = requests.delete(url, verify=False, auth=HTTPBasicAuth(self.nsx_user, self.nsx_password))
        if response.status_code == 200:
            if len(response.text) == 0:
                print(operation, 'operation on', body.get('display_name'), 'completed successfully.')
            else:
                print(response.text)
        else:
            print('Got error:', response.text)


def main(scriptName, args_list):
    ret_status = 0
    print('Running:', scriptName, ' '.join(args_list))
    try:
        with mainObj() as ptr:
            ptr.process(args_list[0:])

    except GoTo as err:
        if err.message:
            print(err.message)
        ret_status = err.errno
    except KeyboardInterrupt:
        print('The iteration has been interrupted')
    except (ValueError, SystemExit, IOError) as err:
        print(err)
        ret_status = 2

    except Exception as err:
        print('Critical error: {0}'.format(err))
        ret_status = 5

    print("Exit with status {0}".format(ret_status))
    return ret_status


if __name__ == "__main__":
    sys.exit(main(os.path.basename(sys.argv[0]), sys.argv[1:]))
