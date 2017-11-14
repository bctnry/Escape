# Escape
Yet Another Blogging Software.

**Please note that Escape is now deprecated**. A new re-designed version of Escape is currently in progress.

### Requirements
It's originally developed in an environment with PHP7&MariaDB. PHP5/Oracle MYSQL is not tested but should be OK.

### Installation

1. Edit ```config.php``` accordingly. You may need to create a new database manually.
2. Load ```./install/DATABASE_SETUP.sql```.
3. ```INSERT INTO Configurations VALUE('[blog name here]','default');;```
4. Manually insert a new user.
Open ```index.php```, insert this line:
``` php
...
    <?php
 	    regUser([your username here],[your password here]);  // THIS!
        if(!$_REQUEST["id"]) {
            echo renderTitle();
...

```
Upload to the server and open the remote ```index.php``` in the browser. This will cause a new user to be created; after doing that, delete ```index.php``` and upload the original one.

5. Done. Open the link to ```index.php``` in the browser, the program should be working now.
