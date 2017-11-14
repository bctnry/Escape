<?php

function dispCommentFormFor($id) {
    echo '
    <div class="comment_form">
    <form action="./index.php" method="POST">
    <input type="hidden" name="id" value="' . $id . '" />
    <input type="hidden" name="mode" value="comment" />
    Name: <br /><input size="64" name="comment_name" /><br />
    Comment body: <br /><textarea rows="10" cols="64" name="comment_body"></textarea><br />
    <input type="submit" value="Submit" />
    </div>
    ';
}

function dispLoginForm() {
    echo '
    <div class="login_form">
    <form action="./admin.php" method="POST">
    <input type="hidden" name="method" value="login" />
    UserID:<br />
    <input size="64" name="login_name" /><br />
    Password:<br />
    <input type="password" name="login_password" /><br />
    <input type="submit" value="Login" />
    </form>
    </div>
    ';
}

function dispBlogpostEditingForm($id,$date,$userid,$title,$body) {
    echo '
    You are editing ID' . $id . ', ' . $date . '.<br />
    <form method="POST">
    <input type="hidden" name="mode" value="manage" />
    <input type="hidden" name="submod" value="editpost" />
    Title: <input name="title" size="128" value="' . $title . '" /><br />
    Body: <textarea name="body" rows="20" cols="128">' . $body . '</textarea><br />
    <input type="submit" value="Modify" />
    </form>
    ';
}
function dispBlogpostEditingFormWith($title,$body) {
    echo '
      <form method="POST">
        <input type="hidden" name="mode" value="post" />
        Title: <input name="title" value="' . $title . '" size="128"/><br />
        Body: <textarea name="body" rows="20" cols="128">' . $body . '</textarea><br />
        <input type="submit" value="Post" />
      </form>
      ';
}
function dispCommentEditingForm($commentid,$blogpostid,$date,$name,$body) {
    echo 'You are editing CID' . $commentid . ' under ID' . $blogpostid . ', ' . $date .'.<br />';
    echo '
    <form action="./admin.php" method="POST">
    <input type="hidden" name="mode" value="commentm" />
    <input type="hidden" name="submod" value="edit" />
    <input type="hidden" name="id" value="' . $commentid . '" />
    Name: <br />
    <input name="comment_name" value="' . $name . '" /><br />
    Comment body:<br />
    <textarea name="comment_body">' . $body . '</textarea><br />
    <input type="submit" value="Modify" />
    </form>';
}
function dispNewBlogpostForm() {
    echo '
    <form method="POST">
      <input type="hidden" name="mode" value="preview" />
      Title: <input name="title" size="128" /><br />
      Body: <textarea name="body" rows="20" cols="128"></textarea><br />
      <input type="submit" value="Preview" />
    </form>
    ';
}


function dispNewUserForm_Backstage() {
    echo '
    <form method="POST">
    <input type="hidden" name="mode" value="userm" />
    <input type="hidden" name="submod" value="newuser" />
    <input type="hidden" name="state" value="phase1" />
    New user name:<br />
    <input name="newuser_name" size="64" /><br />
    New user password:<br />
    <input type="password" name="newuser_password" /><br />
    <input type="submit" value="Register" />
    </form>
    ';
}

function dispUserEditingForm($id) {
    echo '
    <form method="POST">
    <input type="hidden" name="mode" value="userm" />
    <input type="hidden" name="id" value="' . $id . '" />
    <input type="hidden" name="state" value="phase1" />
    You are editing UID' . $id . '.
    <a href="./admin.php?mode=userm&submod=deluser&id=' . $id . '">Delete this user</a><br />
    Username:<br />
    <input name="user_name" size="64" value="' . retrUsername($id) . '" /><br />
    Password:<br />
    <input type="password" name="user_password" /><br />
    <input type="submit" value="Modify" />
    </form>
    ';
}


?>