function convertTime(time) {
    time = time.split('.')
    time.pop()
    time = time.toString().split(' ')
    x = time[0].split('-')
    y = time[1].split(':')
    z = 'AM'
    if (y[0] > 12) {
        y[0] = y[0] - 12;
        z = 'PM'
    }
    
    return "posted on " + x[1] + "/" + x[2] + "/" + x[0] 
    + " at " + y[0] + ":" + y[1] + z
    
    
    
}