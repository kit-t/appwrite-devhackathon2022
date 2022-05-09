# appwrite-devhackathon2022
Submission for Appwrite Hackathon on DEV (2022) - ***The Expenses App***.

`#appwritehack`, `#appwrite`, `#flutter`

### Overview of My Submission
I have built a mobile app to record expenses using Appwrite and Flutter. Appwrite's features used include Database, Auth & Users, Storage and Realtime.  
Since this is my first time using Appwrite and it's been years since I last built an app with Flutter, the [tutorial](https://blog.logrocket.com/appwrite-flutter-tutorial-with-examples/) on LogRocket has been very helpful in getting me started.   

![demo - existing user](https://user-images.githubusercontent.com/45528516/167383259-0ed099d2-6ee5-411d-b731-98183305b8bb.gif) | ![demo - new user](https://user-images.githubusercontent.com/45528516/167383323-99c53239-13ad-42cb-a906-5ac9d7c46791.gif) 
:--:|:--:


### Submission Category:

Mobile Moguls


### Link to Code

`{% embed https://github.com/kit-t/appwrite-devhackathon2022 %}`


### Additional Resources / Info
#### References
- [Using Appwrite with Flutter: A tutorial with examples](https://blog.logrocket.com/appwrite-flutter-tutorial-with-examples/)

## Setup
- Clone the repository
- `yarn install`
- Start [Appwrite](https://appwrite.io/docs/installation)
  - add appwrite/.env (refer appwrite/.env.example)
  - update start:localtunnel script in package.json to your preferred subdomain
  - `yarn start`
  - go to `localhost` in the browser
  - create a user account
- Deploy the Appwrite project
  - `cd appwrite/projects/devhackathon2022`
  - `appwrite login` & login with the credentials in previous step
  - `appwrite deploy --all` to deploy the project
  - create a bucket for expense attachments from Appwrite console
- Run flutter app
  - `cd mobile`
  - `flutter pub get`
  - update mobile/lib/utils/appwrite.dart as necessary
  - `flutter run`

## Useful commands
- Stop appwrite
  `docker-compose stop`
- Uninstall appwrite
  `docker-compose down -v`

