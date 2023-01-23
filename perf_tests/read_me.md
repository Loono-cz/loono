# Perf testing of backend in jMeter

## Download
Download jMeter : https://jmeter.apache.org/download_jmeter.cgi
After download, unzip compressed folder.

## Java
Check if your system has Java in version which meets the jMeter requirements.

The version of Java, you can easily obtain from terminal by this command : 
```
java -version
```

## How to run jMeter on Win
On Windows, just open unziped folder. Next go to folder **bin** and open jar ApacheJMeterer.jar.

## How to run jMeter on Mac
Open terminal, and go to jmeter unziped folder. Next go to bin folder. In this folder is file : **jmeter.sh**
Run this shell file in terminal with command : 
```
sh jmeter.sh
```
## Run tests

After opening jMeter application. Go to Open. Select one of prepared files and load it.

![JMeter view after start up](https://www.tutorialspoint.com/assets/questions/media/61458/macos.jpg)

In every test file (v1,v2,v3), are prepared test Thread Group with specific usecases.
Every Thread Group has inside View Result Tree and Summary Report. These reports are usefull for investigation how concrete Thread Group ended.
And the most important thing, every Thread Group can be run separetly. By right click by mouse on Thread Groupe, in showen options is "Start", the "Start" start running only the Thread Group.

### v1 - origin
**v1 - origin** obtain a few basic test, which doesn't solve secured part of backend.
User part of backend is secured by oAuth over Firebase Auth API.

### v2 and v3 info
In v2 and v3 is implemented creation of users in Dev Firebase Auth database. Then is possible to log in over API with credentials and get authorization token to Loono API.

In v2 and v3 are some test global user defined variables. These varibales are for controling and tests config.

UserCount	
- count of users to create, test, delete etc.



AccountMailPrefix 
- prefix for generated emails in style F.E: test 
- test0001@loono.cz test0002@loono.cz etc.

AccountPass 
- pass for test profiles :)


In Firebase backend is neccesary to increase creation of 1000 users per hour, if it is neccesary to create multiple thousands it need time to prepare. 

Account creation and deletion limits

	New account creation	100 accounts/IP address/hour
	Account deletion	10 accounts/second

	Note: You can schedule a temporary increase to the account creation limit in the Firebase console

It is possible to increase up to 1000 account per one hour.
https://console.firebase.google.com/u/0/project/loonoapp-dev/authentication/settings

Deletion of account is fixed, it is not possible to adjust. It is necessary to limit artificially.


### v2
In v2 is implemented all what is available.

- UserCountCheck
 - Firebase API 	- CreateUsers
	 - create new test users, without checking if these credentials exists in Firebase Auth database
	 - count of users is specified in global user defined variables
 - Firebase API 	- Check and create
	 - at first, try to log in with a generated credentials, (checking if the account exist), if login failed (then the account doesn't exists), then create new test user with these credentials 
 - Loono API 		- OnBoarding
	 - login user with generated credentials
	 - prepare rand account sex and send to onBoarding endpoint
 - Loono API		- Account
	 - return account info
 - Loono API		- Examinations
	 - return account examinations
 - Loono API		- Providers all 		- no Auth
 - Loono API		- Providers details	- no Auth
 - Loono API		- Last update 			- no Auth
 - Loono API		- Delete users
	 - delete user from Loono db and from Firebase API
	 - the proces is:
		 - log in the user
		 - call delete user
 - Firebase API	- Delete users
	 - delete user only from Firebase API


### v3
In v3 is implemented one scenario for perf test of Loono OnBoarding.

It is possible to set auto start at time. This feature help to coordinate distrubitated perf test. It only need synchronized time in PCes or MACes.

 - check if users are created or create new test users
 - start the test when it is needed
	 - the test contains calling of onBoarding with Male or Female sex
	 - small "user think" delay
	 - after "user thinking" (or in app content loading) get account info and examination info
 - after test delete user
	 - delete rate of users is maximaly 10 per second, artificially is reduce to 8/second
