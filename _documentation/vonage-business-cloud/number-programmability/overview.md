---
title: Overview
meta_title: Number programmability service
---

# Overview

> **Note** The Number Programmability service is for [Vonage Business Cloud Customers](https://www.vonage.com/business/) only.

The Vonage Business Cloud (VBC) Number Programmability service enables you to:

* Forward a VBC call to a Nexmo [Voice API](/voice/voice-api/api-reference) application
* Connect calls to a [VBC extension](/vonage-business-cloud/extension-api/guides/vbc-extension) from a Voice API [NCCO](/voice/voice-api/guides/ncco) without using a PSTN

## What can you do with it?
You can use all the power and flexibility of the Nexmo Voice API together with the supporting VBC [Account](/vonage-business-cloud/account-api/api-reference), [Extension](/vonage-business-cloud/extension-api/api-reference) and [User](/vonage-business-cloud/user-api/api-reference) APIs to create fully customized call experiences for your customers, including:

* Interactive voice response (IVR) systems that link to your CRM system to personalise the menu options to your customers' needs
* Voicebots that use natural language processing and/or AI to answer simple questions spoken by your customers
* Automatic proxying of local numbers based on the area code dialled
* Voice broadcasts to alert customers to important news or events
* Real-time sentiment analysis to gauge the "mood" of a call
* Calendar integration to check the free/busy status of a call recipient and react accordingly

## Getting Started
To use the Number Programmability service, you need:

* A Vonage Business Cloud account
* A Nexmo account

You must then:

1. [Add the Number Programmability service]() to your VBC account
2. [Configure the Number Programmability service]() with one or more VBC numbers
3. [Create a Nexmo Voice API application]() to store security and configuration information
4. [Link your VBC number(s)]() to the Voice API application

## Using the Number Programmability service

You will use the [Nexmo Voice API](/voice/voice-api/api-reference) to build interactive and customised call experiences for your users.

To forward an inbound call on one of your linked VBC numbers to your Nexmo Voice API application, you create a [webhook]() endpoint in your code and configure the URL in your Nexmo account. This is so that Nexmo's APIs can alert your application when a call is received and ask for instructions on how to process the call.

You provide these instructions in the form of a [Nexmo Call Control Object (NCCO)]() that defines the list of actions that the call must perform, such as reading a message to your caller using text-to-speech, or collecting input as part of an interactive voice response (IVR) system. Another type of action in the NCCO can route the call to a VBC extension.

We provide [client libraries](https://github.com/Nexmo/) in various languages that take make it easier to work with the Voice API. We also provide VBC-specific APIs that help you retrieve information about your VBC accounts, extensions and users. Visit the Guides and Building Blocks to get started.

## Guides

```concept_list
product: vonage-business-cloud/number-programmability
```

## Building Blocks

```building_block_list
product: vonage-business-cloud/number-programmability
```

## Tutorials

```tutorials
product: vonage-business-cloud/number-programmability
```

## Reference

* [Voice API Reference](/api/voice)
* [NCCO Reference](/voice/voice-api/ncco-reference)
* [Webhook Reference](/voice/voice-api/webhook-reference)



