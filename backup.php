<?php
require_once("./routine.php");
if(isset($_REQUEST["mode"])){
    if(strcmp($_REQUEST["mode"],"export")==0){
        if(hashvalValid()){
            $xmlWriter = new XMLWriter();
            $xmlWriter->openMemory();
            $xmlWriter->setIndent(true);
            $xmlWriter->setIndentString("    ");
            $xmlWriter->startDocument("1.0","UTF-8");
    
            $xmlWriter->startElement("Escape");
            $xmlWriter->startElement("Config");
            $xmlWriter->startElement("Blogname");
            $xmlWriter->text(retrBlogname());
            $xmlWriter->endElement();
            $xmlWriter->startElement("CurrentTemplate");
            $xmlWriter->text(retrCurrentTemplate());
            $xmlWriter->endElement();
            $xmlWriter->endElement();
            $xmlWriter->startElement("Posts");
    
            forBlogposts(
              function($id,$date,$userid,$title,$body){
                global $xmlWriter;
                $xmlWriter->startElement("Post");
                $xmlWriter->startAttribute("ID"); $xmlWriter->text($id); $xmlWriter->endAttribute();
                $xmlWriter->startAttribute("Date"); $xmlWriter->text($date); $xmlWriter->endAttribute();
                $xmlWriter->startAttribute("UserID"); $xmlWriter->text($userid); $xmlWriter->endAttribute();
                $xmlWriter->startElement("Title"); $xmlWriter->text($title); $xmlWriter->endElement();
                $xmlWriter->startElement("Body"); $xmlWriter->text($body); $xmlWriter->endElement();
                $xmlWriter->endElement();
              }
            );  
            $xmlWriter->endElement();
            $xmlWriter->startElement("Comments");
            forBlogposts(function($id,$date,$userid,$title,$body){
              global $xmlWriter;
              forCommentsAtBlogID($id,function($commentid,$blogpostid,$date,$name,$body){
                global $xmlWriter;
                $xmlWriter->startElement("Comment");
                $xmlWriter->startAttribute("ID"); $xmlWriter->text($commentid); $xmlWriter->endAttribute();
                $xmlWriter->startAttribute("BlogpostID"); $xmlWriter->text($blogpostid); $xmlWriter->endAttribute();
                $xmlWriter->startAttribute("Date"); $xmlWriter->text($date); $xmlWriter->endAttribute();
                $xmlWriter->startElement("Name"); $xmlWriter->text($name); $xmlWriter->endElement();
                $xmlWriter->startElement("Body"); $xmlWriter->text($body); $xmlWriter->endElement();
                $xmlWriter->endElement();
              });
            });
            $xmlWriter->endElement();
            $xmlWriter->startElement("Users");
            forUsers(
              function($userid,$username,$userpassword){
                global $xmlWriter;
                $xmlWriter->startElement("User");
                $xmlWriter->startAttribute("ID");
                $xmlWriter->text($userid);
                $xmlWriter->endAttribute();
                $xmlWriter->startAttribute("Username");
                $xmlWriter->text($username);
                $xmlWriter->endAttribute();
                $xmlWriter->startAttribute("Password");
                $xmlWriter->text($userpassword);
                $xmlWriter->endAttribute();
                $xmlWriter->endElement();
              }
            );
            
            $xmlWriter->endElement();
            $xmlWriter->endElement();
            $xmlWriter->endDocument();
            echo $xmlWriter->outputMemory();
        }
    } else if(strcmp($_REQUEST["mode"],"import")==0){

    }
}
?>