## Under Construction

#### Plugin for Redmine

Plugin for Redmine that disables all pages except account(login-logout) for non-admin users while technical operations runs.
You can set technical operations period and additional message to users.

![settings](https://github.com/dkuk/under_construction/raw/master/screenshots/settings.png "settings")

![message](https://github.com/dkuk/under_construction/raw/master/screenshots/message.png "message")

Also plugin implemented optionally functionality to send xmpp notification for all active users (RedmineSender plugin required!).

![settings2](https://github.com/dkuk/under_construction/raw/master/screenshots/settings2.png "settings2")

#### Installation
To install plugin, go to the folder "plugins" in root directory of Redmine.
Clone plugin in that folder.

		git clone https://github.com/dkuk/under_construction.git

Perform plugin migrations (make sure performing command in the root installation folder of «Redmine»):

		rake redmine:plugins:migrate NAME=under_construction

Restart your web-server.

#### Supported Redmine, Ruby and Rails versions.

Plugin aims to support and is tested under the following Redmine implementations:
* Redmine 2.3.1
* Redmine 2.3.2
* Redmine 2.3.3

Plugin aims to support and is tested under the following Ruby implementations:
* Ruby 1.9.2
* Ruby 1.9.3
* Ruby 2.0.0

Plugin aims to support and is tested under the following Rails implementations:
* Rails 3.2.13

#### Copyright
Copyright (c) 2011-2013 Vladimir Pitin, Danil Kukhlevskiy.
[skin]: https://github.com/tdvsdv/redmine_alex_skin
For better appearance we recommend to use this plugin with Redmine skin of our team - [Redmine Alex Skin][skin].

Another plugins of our team you can see on site http://rmplus.pro
