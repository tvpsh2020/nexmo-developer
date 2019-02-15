---
title: Link your VBC numbers
description: Associate your VBC numbers with a Nexmo Voice API application.
navigation_weight: 4
---
# Link Your VBC Numbers

After you have [created a Nexmo Voice Application](), you need to link your VBC programmable number(s) to it. You can use the [Nexmo CLI](/tools) for this step too.

To associate a VBC programmable number with your Application, execute the following command, replacing:

* `<number>` with your VBC programmable number.
* `<application_id>` with your Nexmo Voice Application `application_id`. 

    ```sh
    $ nexmo link:app <number> <application_id>  

> The `application_id` is returned when you execute the `nexmo app:create` command and is also available in the [Nexmo Developer Dashboard](https://dashboard.nexmo.com/voice/your-applications).   

Once you have created an Application and linked your programmable number(s) to it, you are ready to begin developing. See the building blocks and tutorials to get started.
