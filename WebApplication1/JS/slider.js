function leftArrow() {    
    document.getElementById("hdn_index").value = "-1";
    __doPostBack("UpdatePanel3", "");
}
function rightArrow() {    
    document.getElementById("hdn_index").value = "+1";
    __doPostBack("UpdatePanel3", "");
}