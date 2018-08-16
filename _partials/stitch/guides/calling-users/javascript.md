---
title: JavaScript
language: javascript
---

# App to App Call Convenience method for JavaScript

In this guide we'll cover adding call methods to the application we have created in the [simple conversation with audio](/stitch/in-app-voice/guides/enable-audio/javascript) guide. We'll deal with member call events that trigger on the application and call state events that trigger on the Call object.

## Concepts

This guide will introduce you to the following concepts:

- **Calls** - calling a User in your application 
- **Call Events** - `member:call` event that fires on an Application
- **Call Status Events** - `call:status:changed` event that fires on an Application when a status in the Call changes

## Before you begin
- Run through the [previous guide](/stitch/in-app-voice/guides/enable-audio/javascript)

## 1 - Update the JavaScript App

We will use the application we have already created for [the first audio getting started guide](/stitch/in-app-voice/guides/enable-audio/javascript). All the basic setup has been done in the previous guides and should be in place. We can now focus on updating the client-side application.

### 1.1 - Add call control UI

First, we'll add the UI for a user to create and end a call to another user. We'll also add UI in order to be notified for an incoming call. We'll hide the `call-incoming` and `call-members` using CSS until the user is interacting with a call. Let's add the UI at the top of the conversations area.

```html
  <style>
    #call-incoming, #call-members {
      display: none
    }
  </style>
  <section id="conversations">
    <form id="call-form">
      <h1>Call User</h1>
      <input type="text" name="username" value="">
      <input type="submit" value="Call" />
    </form>
    <div>
      <div id="call-incoming">
        <p></p><button id="yes">Yes</button><button id="no">No</button>
      </div>
      <div id="call-members">
        <p></p><button id="hang-up">Hang Up</button>
      </div>
    </div>
    ...
  </section>
```

And add the new UI in the class constructor

```javascript
constructor() {
  ...
  this.callForm = document.getElementById('call-form')
  this.callIncoming = document.getElementById('call-incoming')
  this.callMembers = document.getElementById('call-members')
  this.callYes = document.getElementById('yes')
  this.callNo = document.getElementById('no')
  this.hangUpButton = document.getElementById('hang-up')
}
```


### 1.2 - Add helper methods

We hid the `call-incoming` and `call-members` elements via CSS, so let's add `showCallIncoming(member)` and `showCallMembers(member)` as a helper methods to display the incoming call notification and add information about the members in a call:

```javascript
showCallIncoming(member) {
  var memberName
  if (member == "unknown") {
    memberName = "a phone"
  } else {
    memberName = member.user.name
  }
  this.callIncoming.style.display = "block"
  this.callIncoming.children[0].textContent = "Incoming call from " + memberName + ". Do you want to answer?"
}

showCallMembers(member) {
  var memberName
  if (member == "unknown") {
    memberName = "a phone"
  } else {
    memberName = member.user.name
  }
  this.callMembers.style.display = "block"
  this.callIncoming.style.display = "none"
  this.callMembers.children[0].textContent = "You are in a call with " + memberName
}
```

We've added some logic in the methods in order to identify the caller as a User in the application or a person calling from a phone (see: [Phone to App Calls Guide](/stitch/in-app-voice/inbound-pstn) on how you can do that). When we receive a phone call into our application, the member is listed as `unknown`.

### 1.3 - Add `member:call` listener

Next, we'll add a listener for `member:call` events on the app, so that we can let the user know when someone calls. We'll call the `showCallIncoming` method we just created, and that sets up the UI that allows a user to either `answer()` the incoming call or `hangsUp()`. If the user answers the call, the SDK automatically creates an `<audio>` element and passes the `stream` into it. So we'll have to call `showCallMembers` in order to display information about the call and a way to hang up the call. Let's update the `app` promise after `login(userToken)` with the code:

```javascript
...
.login(userToken)
.then(app => {
  ...
  this.app = app

  app.on("member:call", (member, call) => {
    this.call = call
    console.log("member:call - ", call);
    if ((this.call.from != "unknown") && (this.app.me.name != this.call.from.user.name)) {
      this.showCallIncoming(call.from)
    } else {
      this.showCallMembers("unknown")
    }
  })
})
```

### 1.4 - Add Call functionality

With these first parts we're listening `member:call` events on the application. Now let's see how to trigger those type of events, by making a call. Let's add an event listener for `callForm` inside the `setupUserEvents()` method. We'll take a list of user names from the input and pass those to the `call()` method on the Application object.
The call() method wraps the creation of a conversation, adding the users to it and finally the audio enabling and disabling. 

```javascript
setupUserEvents() {
  ...

  this.callForm.addEventListener('submit', (event) => {
    event.preventDefault()
    var usernames = this.callForm.children.username.value.split(",").map(username => username.trim())

    this.app.call(usernames)
  })
}
```

We'll also have to setup listeners for the other buttons we created in order to manage the call, so let's add them to `setupUserEvents()`.

```javascript
setupUserEvents() {
  ...

  this.hangUpButton.addEventListener('click', () => {
    this.call.hangUp()
    this.callMembers.style.display = "none"
  })

  this.callYes.addEventListener('click', () => {
    this.call.answer()
    this.showCallMembers(this.call.from)
  })

  this.callNo.addEventListener('click', () => {
    this.call.hangUp()
    this.callIncoming.style.display = "none"
  })
}
```

If we want to be notified on [call status](/stitch/in-app-voice/call-statuses) changes such as `started`, `busy`, `rejected`, or `answered`, we need to add a listener for `call:status:changed` on the Application. Let's update the `app` promise after `login(userToken)` with the code:

```javascript
...
.login(userToken)
.then(app => {
  ...

  app.on("call:status:changed", (call) => {
    console.log("call:status:changed - ", call.status)
  })
})
```

### 1.5 - Open the conversation in two browser windows

Now run `index.html` in two side-by-side browser windows, making sure to login with the user name `jamie` in one and with `alice` in the other. Call one from the other, accept the call and start talking. You'll also see events being logged in the browser console.

Thats's it! Your page should now look something like [this](https://github.com/Nexmo/stitch-js-quickstart/blob/master/calling-users/index.html).

### 1.6 - Calling an App User from a Phone

After you've set up your app to handle incoming calls, you can follow the [Phone to App Calls Guide](/stitch/in-app-voice/inbound-pstn) to find out how in addition to calls from other app users, you can connect calls from phones devices via the Voice API.

## Where next?

- Have a look at the <a href="/sdk/stitch/javascript/" target="_blank">Nexmo Stitch JavaScript SDK API Reference</a>
