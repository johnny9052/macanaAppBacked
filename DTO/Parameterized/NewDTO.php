<?php

require_once ('../../DTO/BaseDTO.php');

class NewDTO extends BaseDTO {
    
    private $id;
    private $title;
    private $description;
    private $date;
    private $urlImage;
    private $urlVideo;
    
    function __Construct($id, $title, $description, $date, $urlImage, $urlVideo) {
        $this->id = $id;
        $this->title = $title;
        $this->description = $description;
        $this->date = $date;
        $this->urlImage = $urlImage;
        $this->urlVideo = $urlVideo;
    }
    
    
    
    function getId() {
        return $this->id;
    }

    function getTitle() {
        return $this->title;
    }

    function getDescription() {
        return $this->description;
    }

    function getDate() {
        return $this->date;
    }

    function getUrlImage() {
        return $this->urlImage;
    }

    function getUrlVideo() {
        return $this->urlVideo;
    }

    function setId($id) {
        $this->id = $id;
    }

    function setTitle($title) {
        $this->title = $title;
    }

    function setDescription($description) {
        $this->description = $description;
    }

    function setDate($date) {
        $this->date = $date;
    }

    function setUrlImage($urlImage) {
        $this->urlImage = $urlImage;
    }

    function setUrlVideo($urlVideo) {
        $this->urlVideo = $urlVideo;
    }




    
    

}
