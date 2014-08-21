window.onload = function () {
    var screenWidth = screen.width;
    document.getElementById('hidden_screenwidth').value = screenWidth;

    document.getElementById('hidden_chrt1Width').value = document.getElementById('resize-chrt1').offsetWidth;
    document.getElementById('hidden_chrt2Width').value = document.getElementById('resize-chrt2').offsetWidth;
    document.getElementById('hidden_chrt3Width').value = document.getElementById('resize-chrt3').offsetWidth;
    document.getElementById('hidden_rsz1').value = document.getElementById('two-chrts-rsz1').offsetWidth;
    document.getElementById('hidden_rsz2').value = document.getElementById('two-chrts-rsz2').offsetWidth;
    document.getElementById('hidden_chrt5Width').value = document.getElementById('resize-chrt5').offsetWidth;
    __doPostBack("UpdatePanel1", "");
}