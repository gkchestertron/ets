//convert race times as strings to milliseconds
String.prototype.toMsec = function () {
    var msplit  = this.split('.'),
        hms     = msplit[0].split(':'),
        ms      = parseInt(msplit[1]),
        hours   = parseInt(hms[0]),
        minutes = parseInt(hms[1]),
        seconds = parseInt(hms[2]);

    return (3600*hours + 60*minutes + seconds) * 1000 + ms;
}

//convert plural names to singular for router
String.prototype.singular = function () {
    if (this.substring(this.length - 3, this.length) === 'ies') {
        return this.substr(0, this.length - 3) + 'y';
    }
    return this.substr(0, this.length -1);
}

//convert milliseconds back into race time string
Number.prototype.toRaceTime = function () {
    var ms        = this % 1000,
        ts        = (this - ms)/1000,
        hours     = Math.floor(ts/3600),
        minutes   = Math.floor((ts - hours * 3600)/60),
        seconds   = Math.floor(ts - (hours * 3600 + minutes * 60)),
        h_string  = (hours   < 10 || hours === 0)   ? "0" + hours   : hours,
        m_string  = (minutes < 10 || minutes === 0) ? "0" + minutes : minutes,
        s_string  = (seconds < 10 || seconds === 0) ? "0" + seconds : seconds;

    if (ms == 0 || ms < 10) {
        ms_string = "00" + ms;
    } else if (ms < 100) {
        ms_string = "0" + ms;
    } else {
        ms_string = ms + '';
    }
    return h_string + ":" + m_string + ":" + s_string + "." + ms_string;
}
