Based on the fork project and https://github.com/VICTOR-LUO-F/aliyun-sms to build an Aliyun SMS notification package for zammad.

可以follow这里：https://lcx.wien/blog/how-to-create-your-custom-zammad-package/ 将rb文件编译成 szpm
其实就是将rb文件做成base64，然后填写到这里的szpm的模板的对应位置就可以了

==================================================

![Sms77.io Logo](https://www.sms77.io/wp-content/uploads/2019/07/sms77-Logo-400x79.png "sms77")

# Zammad Package for the Sms77.io SMS Gateway

## Installation

1. Download **sms77-sms.szpm** file from [Latest Releases](https://github.com/sms77io/zammad/releases/latest "Latest Releases")
2. Open up your Zammad **Dashboard**
2. Click on **Admin**, navigate to **Manage->System->Packages** and press **Choose File**
3. Locate the downloaded **sms77-sms.szpm** and click **Install Package**
4. Go to **Manage->Channels->SMS->SMS Notification** and choose **sms77**
5. Type in your Sms77.io **credentials**, test and you are ready to go

### License

This respository is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
