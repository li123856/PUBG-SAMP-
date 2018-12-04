#include <a_samp>

#if !defined gettime_ex
    #define gettime_ex gettime
#endif

#define GetCurrentDate()     GetSpecificDate(-1, -1, -1)
#define IsLeapYear(%1)         ((%1 % 4 == 0 && %1 % 100 != 0) || %1 % 400 == 0)

stock GetDayOfWeek(day, month, year) // Basado en http://es.wikipedia.org/wiki/Congruencia_de_Zeller
{
    static const DaysWeek[][24] = {
        "周一",        //       0
        "周二",       //      1
        "周三",    //      2
        "周四",       //      3
        "周五",      //      4
        "周六",       //      5
        "周日"       //      6
    };
    new
        d_[4],
        m_[10]
    ;

    d_[0] = (14-month) / 12, d_[2] = year - d_[0], d_[1] = month + (12*d_[0]) - 2;
    d_[3] = (day + d_[2] + (d_[2]/4) - (d_[2]/100) + (d_[2]/400) + (31*d_[1]) / 12) % 7;

    if(d_[3] == 0)
    {
        d_[3] = sizeof(DaysWeek) - 1;
    }
    else
    {
        d_[3] -= 1;
    }

    format(m_, sizeof(m_), "%s", DaysWeek[d_[3]]);
    return m_;
}
stock GetDayOfWeekEx(day, month, year) 
{
    new
        d_[4];

    d_[0] = (14-month) / 12, d_[2] = year - d_[0], d_[1] = month + (12*d_[0]) - 2;
    d_[3] = (day + d_[2] + (d_[2]/4) - (d_[2]/100) + (d_[2]/400) + (31*d_[1]) / 12) % 7;

    if(d_[3] == 0)
    {
        d_[3] = 7 - 1;
    }
    else
    {
        d_[3] -= 1;
    }
    return d_[3];
}
stock GetDate()
{
    new output[40];

    new _dat[3];
    gettime_ex(_dat[0], _dat[1], _dat[2]);
    format(output, sizeof(output), "%i:%i", _dat[0], _dat[1]);

    format(output, sizeof(output), "%s - %s", GetCurrentDate(), convert24HoursTo12Hours(output));
    return output;
}

stock GetTime()
{
    new
        m_[34],
           d_[3]
    ;

    gettime_ex(d_[0], d_[1], d_[2]), format(m_, sizeof(m_), "%02d:%02d", d_[0], d_[1], d_[2]);
       return m_;
}

stock GetMonthName(month)
{
    static const MonhtsYears[12][] = {
        "一月",            // 0
        "二月",          // 1
        "三月",            // 2
        "四月",            // 3
        "五月",                // 4
        "六月",               // 5
        "七月",               // 6
        "八月",           // 7
        "九月",          // 8
        "十月",          // 9
        "十一月",           // 10
        "十二月"            // 11
    };
    new
        month_str[24]
    ;

    if(month > 0 && month <= sizeof(MonhtsYears)) {
        format(month_str, sizeof(month_str), "%s", MonhtsYears[month-1]);
    }
    else{
        format(month_str, sizeof(month_str), "Unknown");
    }
    return month_str;
}

stock getTotalDaysInMonth(_month, year)
{
    new dias[] = {
        31, // Enero
        28, // Febrero
        31, // Marzo
        30, // Abril
        31, // Mayo
        30, // Junio
        31, // Julio
        31, // Agosto
        30, // Septiembre
        31, // Octubre
        30, // Noviembre
        31  // Diciembre
    };
    return ((_month >= 1 && _month <= 12) ? (dias[_month-1] + (IsLeapYear(year) && _month == 2 ? 1 : 0)) : 0);
}

stock GetSpecificDate(day = -1, month = -1, year = -1)
{
    new str[64];

    if(day == -1 && month == -1 && year == -1)
    {
        new _year, _month, _day;

        getdate(_year, _month, _day);

        format(str, sizeof(str), "%i %s, %s, %i", _day, GetDayOfWeek(_day, _month, _year), GetMonthName(_month), _year);
    }
    else
    {
        format(str, sizeof(str), "%i %s, %s, %i", day, GetDayOfWeek(day, month, year), GetMonthName(month), year);
    }
    return str;
}

stock GetTotalDaysFromYear(year) return IsLeapYear(year) ? 366 : 365;

stock GetLeftDaysFromYear(day, _month, year) return GetTotalDaysFromYear(year) - CountDaysSpentInYear(day, _month, year);

stock CountDaysSpentInYear(day, _month, Year)
{
    new SumaDeDias = day;
    for(new i = 1; i <= _month-1; i++)
        SumaDeDias += getTotalDaysInMonth(i, Year);

    return SumaDeDias;
}

stock GetDateDateAddingDays(days, months, _day, _month, _year, &dia, &mes, &year)
{
    return UnixToDate(DateToUnix(_day, _month, _year) + (days * (60 * 60 * 24) + months * (60 * 60 * 24 * 30)), dia, mes, year);
}

stock GetCurrentDateAddingDays(days, &dia, &mes, &year)
{
    new _year, _month, _day;

    getdate(_year, _month, _day);
    GetDateDateAddingDays(days, 0, _day, _month, _year, dia, mes, year);
    return 1;
}

stock GetCurrentDateAddingMonths(months, &dia, &mes, &year)
{
    new _year, _month, _day;

    getdate(_year, _month, _day);
    GetDateDateAddingDays(0, months, _day, _month, _year, dia, mes, year);
    return 1;
}

stock GetDateFromStr_YYYYMMDDHHMM(str[], &day, &month, &year, &hour, &minute)
{
    // formato -> YYYY/mm/dd, hh:mm
    new numberStr[12];
    strmid(numberStr, str, 8, 10);
    day = strval(numberStr);

    strmid(numberStr, str, 5, 7);
    month = strval(numberStr);

    strmid(numberStr, str, 0, 4);
    year = strval(numberStr);

    strmid(numberStr, str, 12, 14);
    hour = strval(numberStr);

    strmid(numberStr, str, 15, strlen(str)-1);
    minute = strval(numberStr);
    return 1;
}

stock GetDateFromStr_DDMMYYYYHHMM(str[], &day, &month, &year, &hour, &minute)
{
    // formato -> dd/mm/YYYY, hh:mm
    new numberStr[12];
    strmid(numberStr, str, 0, 2);
    day = strval(numberStr);

    strmid(numberStr, str, 3, 5);
    month = strval(numberStr);

    strmid(numberStr, str, 6, 10);
    year = strval(numberStr);

    strmid(numberStr, str, 12, 14);
    hour = strval(numberStr);

    strmid(numberStr, str, 15, strlen(str)-1);
    minute = strval(numberStr);
    return 1;
}

stock FixFormatHour(hour, minute)
{
    // 6:3 convert to 06:03

    new str[9];
    new bool:fixedHour[2];

    if(0 <= hour <= 9){
        format(str, sizeof(str), "0%i", hour);
        fixedHour[0] = true;
    }
    if(0 <= minute <= 9){
        format(str, sizeof(str), "%s:0%i", str, minute);
        fixedHour[1] = true;
    }
    if(fixedHour[0] == false){
        format(str, sizeof(str), "%i", hour);
    }
    if(fixedHour[1] == false){
        format(str, sizeof(str), "%s:%i", str, minute);
    }

    /* format(str, sizeof(str), "%02d:%02d", hour, minute); <-- This does not work, does not meet the need correctly. */
    return str;
}

stock convert24HoursTo12Hours(time[])
{
    // 13:00 -> 01:00 PM

    new output[32];
    new pos = strfind(time, ":");

    strmid(output, time, 0, pos+1);
    new hora = strval(output);

    strmid(output, time, pos+1, strlen(time));
    new minuto = strval(output);

    new _formatTime[3];
    if(hora >= 13 && hora <= 24){
        format(_formatTime, sizeof(_formatTime), "PM");
        hora = hora - 12;
    }
    else if(hora >= 0 && hora <= 12){
        format(_formatTime, sizeof(_formatTime), "AM");
    }
    format(output, sizeof(output), "%s %s", FixFormatHour(hora, minuto), _formatTime);
    return output;
}

stock PrintDate() // YYYYMMDDHHMM
{
    new output[40],
        _dat[6];

    getdate(_dat[0], _dat[1], _dat[2]);
    gettime_ex(_dat[3], _dat[4], _dat[5]);

    format(output, sizeof(output), "%02d/%02d/%d, %02d:%02d:%02d", _dat[0], _dat[1], _dat[2], _dat[3], _dat[4], _dat[5]);
    return output;
}

stock DateToUnix(day, month, year)
{
    new x = 0;
    for(new j = 1970; j < year; j++)
    {
        x += (60 * 60 * 24)* 365;
        if(IsLeapYear(j)){
            x += (60*60)*24;
        }
    }
    month--;
      for (new i = 0; i < month; i++){
        x += getTotalDaysInMonth(month, year) * 86400;
      }
      x += day * 86400;
    return x;
}

stock UnixToDate(x, &_day, &_month, &_year)
{
    new year = 1970;
    new dia = 1;
    new mes = 1;
    while(x >= 86400) {
         x -= 86400;
           dia ++;
         if(dia > getTotalDaysInMonth(mes, year)) {
               dia = 1;
             mes ++;
               if(mes > 12) {
                year ++;
                mes = 1;
              }
         }
    }
    _day = dia;
    _month = mes;
    _year = year;
    return x;
}


