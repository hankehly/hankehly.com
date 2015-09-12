<?php

$too = "henry.ehly@gmail.com";
$subject = "HankEhly.com Inquiry";
$message = $_POST["message"];
$user_email = $_POST["email"];

$headers  = "From: $user_email\r\n";
$headers .= "Reply-To: $too\r\n";
$headers .= "Return-Path: $too\r\n";
$headers .= "X-Mailer: PHP/" . phpversion(). "\r\n";
$headers .= 'MIME-Version: 1.0' . "\n";
$headers .= 'Content-type: text/html; UTF-8' . "\r\n";
 
if(mail($too,$subject,$message,$headers)) {
    echo 'Your message has been sent.';
} else {
    echo 'Failed to send. Please try again.';
}

?>
<html>
<p>Return to <a href="index.php">hankehly.com</a></p>
</html>