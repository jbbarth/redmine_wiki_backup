Redmine wiki_backup plugin
======================

Allows you to backup your wiki(s) in a static website

It adds a `/wiki_backup` URL that groups all redmine wiki pages you have access to. This is a simplified, flat version of your wiki
pages across your redmine install. All wiki links are converted to wiki_backup links so that you'll stay within the sub-site as long
as possible. This sub-site can be mirrored for offline usage (this is the primary use case). An example script is left in the
`extra/` directory.

PLEASE NOTE this is alpha software, nearly not tested automatically, so you should test it with care before putting it in production.

Installation
------------

This plugin is compatible with Redmine 2.1.0+.

Please apply general instructions for plugins [here](http://www.redmine.org/wiki/redmine/Plugins).

First download the source or clone the plugin and put it in the "plugins/" directory of your redmine instance. Note that this is crucial that the directory is named redmine_wiki_backup !

Then execute:

    $ bundle install
    $ rake redmine:plugins

And finally restart your Redmine instance.

Test status
-----------

|Plugin branch| Redmine Version   | Test Status      |
|-------------|-------------------|------------------|
|master       | 4.2.9             | [![4.2.9][1]][5] |  
|master       | 4.1.7             | [![4.1.7][2]][5] |
|master       | master            | [![master][4]][5]|

[1]: https://github.com/jbbarth/redmine_wiki_backup/actions/workflows/4_2_9.yml/badge.svg
[2]: https://github.com/jbbarth/redmine_wiki_backup/actions/workflows/4_1_7.yml/badge.svg
[4]: https://github.com/jbbarth/redmine_wiki_backup/actions/workflows/master.yml/badge.svg
[5]: https://github.com/jbbarth/redmine_wiki_backup/actions

Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
