# Escape
Yet Another Blogging Software.

**please note that Escape is now deprecated**. a new re-designed version of Escape is currently in progress.

### Requirements
It's originally developed in an environment with php7&mariadb. php5/oracle mysql is not tested but should be ok.

### installation

1. edit ```config.php``` accordingly. you may need to create a new database manually.
2. load ```./install/DATABASE_SETUP.sql```.
3. ```INSERT INTO Configurations VALUE('[blog name here]','default');;```
4. manually insert a new user.
open ```index.php```, insert this line:
``` php
...
    <?php
 	    regUser([your username here],[your password here]);  // THIS!
        if(!$_REQUEST["id"]) {
            echo renderTitle();
...

```
upload to the server and open the remote ```index.php``` in the browser. this will cause a new user to be created; after doing that, delete ```index.php``` and upload the original one.

5. done. open the link to ```index.php``` in the browser, the program should be working now.
