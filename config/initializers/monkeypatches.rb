class String
    def to_msec
        msplit  = self.split('.')
        hms     = msplit[0].split(':')
        ms      = msplit[1].to_i
        hours   = hms[0].to_i
        minutes = hms[1].to_i
        seconds = hms[2].to_i
        (3600*hours + 60*minutes + seconds) * 1000 + ms
    end
end

class Fixnum
    def to_race_time
        ms        = self % 1000
        ts        = (self - ms)/1000
        hours     = ts/3600
        minutes   = (ts - hours * 3600)/60
        seconds   = ts - (hours * 3600 + minutes * 60)
        h_string  = (hours   < 10 || hours == 0)   ? "0#{hours}"   : "#{hours}"
        m_string  = (minutes < 10 || minutes == 0) ? "0#{minutes}" : "#{minutes}"
        s_string  = (seconds < 10 || seconds == 0) ? "0#{seconds}" : "#{seconds}"
        if ms == 0 || ms < 10
            ms_string = "00#{ms}"
        elsif ms < 100
            ms_string = "0#{ms}"
        else
            ms_string = "#{ms}"
        end
        "#{h_string}:#{m_string}:#{s_string}.#{ms_string}"
    end
end
