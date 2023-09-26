function output_datetime = convertDateTime(input_datetime)
%CONVERTDATETIME converts datetime from format in vex file to format used
%by VieRDS
    new_datetime = replace(input_datetime,["y","d","h","m"],"-");
    new_datetime = erase(new_datetime,"s");
    new_datetime = datetime(new_datetime,"Format","uuuu-DDD-HH-mm-ss");
    output_datetime = string(new_datetime,'yyyy,MM,dd,HH,mm,ss');
end