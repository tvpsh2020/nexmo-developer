---
title: Authenticate an Application
description: Configure authentication details to access the APIs
navigation_weight: 2
---

# Authenticate an Application

Once you have [created your application](), you need to configure it so that it can authenticate against the [Account](/vonage-business-cloud/account), [Extension](/vonage-business-cloud/extension) and [User](/vonage-business-cloud/user) APIs using [OAuth](https://oauth.net/2/).

## Configuring authentication

1. Select "My Applications" in the left-hand navigation menu.

2. On the "My Application" page, locate your Application in the table and click the "View" link in the "Actions" column.

3. Select the "Production Keys" tab:

  ![Screenshot showing the Production Keys tab of the My Applications page](/assets/images/vbc/production-keys.png)

  > Note the list of Grant Types. The [grant type](https://oauth.net/2/grant-types/) is the method OAuth uses to generate an access token. The `authorization code` grant type is the one most web and mobile apps use and this is selected by default (`Code`).

## Generating the authentication keys

4. In the "Callback URL" field, enter a valid callback URL that your application will use to receive the generated token. If you haven't created your application yet, enter `http://localhost" for now and remember to revisit this when you are ready to test it.

5. Click the "Generate Keys" button. This generates the "Consumer Key" and "Consumer Secret" key and secret respectively that your application will use to request a token.

6. Look at the "Endpoint Examples" and "Generating Access Tokens" samples to learn how to request the authentication token in your application:

![Screenshot showing endpoint and generating access token examples](/assets/images/vbc/examples.png)

