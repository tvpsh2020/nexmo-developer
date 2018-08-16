## Before you begin

* Ensure you have [Node.JS](https://nodejs.org/) installed
* Create a free Nexmo account - [signup](https://dashboard.nexmo.com)
* Install the Nexmo CLI:

    ```bash
    $ npm install -g nexmo-cli@beta
    ```

    Setup the CLI to use your Nexmo API Key and API Secret. You can get these from the [setting page](https://dashboard.nexmo.com/settings) in the Nexmo Dashboard.

    ```bash
    $ nexmo setup api_key api_secret
    ```

## 1 - Setup

_Note: The steps within this section can all be done dynamically via server-side logic. But in order to get the client-side functionality we're going to manually run through setup._

### 1.1 - Create a Nexmo Application

Create a Nexmo application within the Nexmo platform to use within this guide.

```bash
$ nexmo app:create "My Stitch App" https://example.com/answer https://example.com/event --type=rtc --keyfile=private.key
```

The output of the above command will be something like this:

```bash
Application created: aaaaaaaa-bbbb-cccc-dddd-0123456789ab
No existing config found. Writing to new file.
Credentials written to /path/to/your/local/folder/.nexmo-app
Private Key saved to: private.key
```

The first item is the Application ID which you should take a note of. We'll refer to this as `YOUR_APP_ID` later. The last value is a private key location. The private key is used to generate JWTs that are used to authenticate your interactions with Nexmo.


### 1.1 - Create an User

Create an user who will participate in a call:

```bash
$  nexmo user:create name="jamie"
```

The output of the above command will be something like this:

```bash
User created: USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

### 1.2 - Generate User JWT

Generate a JWT for the user and take a note of it. Remember to change the `YOUR_APP_ID` value in the command:

```bash
$ USER_JWT="$(nexmo jwt:generate ./private.key sub=jamie exp=$(($(date +%s)+86400)) acl='{"paths":{"/v1/users/**":{},"/v1/conversations/**":{},"/v1/sessions/**":{},"/v1/devices/**":{},"/v1/image/**":{},"/v3/media/**":{},"/v1/applications/**":{},"/v1/push/**":{},"/v1/knocking/**":{}}}' application_id=YOUR_APP_ID)"
```

*Note: The above command saves the generated JWT to a `USER_JWT` constant. It also sets the expiry of the JWT to one day from now.*

You can see the JWT for the user by running the following:

```bash
$ echo $USER_JWT
```

## 2 - Create the JavaScript App

With the basic setup in place we can now focus on the client-side application.

### 2.1 - An HTML Page with a Basic UI

Create an `index.html` page and add a very basic UI for the conversation functionality.

The UI contains:

* A simple login area. We'll be stubbing out a fake login process, but in a real application it would be expected for you to integrate with your chosen login system.
* A blank view for adding the UI for calling later on

```html
<!DOCTYPE html>
<html>
<head>
  <style>
    #calling {
      display: none;
    }
  </style>
</head>
<body>

  <form id="login">
    <h1>Login</h1>
    <input type="text" name="username" value="">
    <input type="submit" value="Login" />
  </form>

  <section id="calling">

  </section>

  <script>
    // Your code will go here
  </script>

</body>
</html>
```

### 2.2 - Add the Nexmo Stitch JS SDK

Install the Nexmo Stitch JS SDK

```bash
$ npm install nexmo-stitch
```

Include the Nexmo Stitch JS SDK in the `<head>`

```html
<script src="./node_modules/nexmo-stitch/dist/conversationClient.js"></script>
```

### 2.3 - Stubbed Out Login

Next, let's stub out the login workflow.

Define an object to store the User JWT that was created earlier and set the key value pair to the username you created earlier (for us it's going to be `jamie`) and the `USER_JWT` value.

Lastly we'll create a class called `ChatApp` that creates some instance variables selecting our HTML elements for use later, an error logging method, an event logging method and stub out the functions we'll be creating later.

```html
<script>
var JWTs = {
  "jamie": 'YOUR USER_JWT'
}

class ChatApp {
  constructor() {
    this.loginForm = document.getElementById('login')
    this.setupUserEvents()
  }

  errorLogger(error) {
      console.log(error)
  }

  eventLogger(event) {
      return () => {
          console.log("'%s' event was sent", event)
      }
  }

  authenticate(username) { // TODO }

  login() { // TODO }

  setupUserEvents() { // TODO }
}

new ChatApp()
</script>
```

Let's fill in the `authenticate` function. For now, stub it out to always return the value asociated with the username in the `JWTs` object. This is where you would normally use the users session to authenticate the user and return their JWT.

```js
authenticate(username) {
  return JWTs[username]
}
```

Within `setupUserEvents` we'll bind to `submit` events on the form. When this form is submitted then call `authenticate` to get the user token. Finally, hide the login, show the blank calling section:

```js
setupUserEvents() {
  this.loginForm.addEventListener('submit', (event) => {
    event.preventDefault()
    const userToken = this.authenticate(this.loginForm.children.username.value)
    if (userToken) {
      document.getElementById('calling').style.display = 'block'
      document.getElementById('login').style.display = 'none'
      this.login(userToken)
    }
  })
}
```

### 2.4 - Connect and Login to Nexmo

Within the `login` function, create an instance of the `ConversationClient` and login the current user in using the User JWT.

```js
login(userToken) {
  new ConversationClient({ debug: false })
    .login(userToken)
    .then(app => console.log('*** Logged into app', app))
    .catch(this.errorLogger)
}
```
