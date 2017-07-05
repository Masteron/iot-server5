function getDate()
{
    var date = new Date();
    var hours = date.getHours();
    var minutes = date.getMinutes();
    var seconds = date.getSeconds();
    var day = date.getDate();
    var month = date.getMonth() + 1;
    var year = date.getYear() + 1900;
    if(seconds < 10)
    {
        seconds = '0' + seconds;
    }
    if(minutes < 10)
    {
        minutes = '0' + minutes;
    }
    if(hours < 10)
    {
        hours = '0' + hours;
    }
    document.getElementById('clock').innerHTML = hours + ':' + minutes + ':' + seconds;
}
setInterval(getDate, 0);
