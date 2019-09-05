
function CipherText = ENIGMA_II_Encrypt(PlainText,Key)

tic
    %Defining the wheels as an array
    Wheels = ['abcdefghijklmnopqrstuvwxyz';'acedfhgikjlnmoqprtsuwvxzyb';'azyxwvutsrqponmlkjihgfedcb'];
    
    Wheels = Wheels - 'a';
    
    %Defining variables
    
    CipherText = (1:length(PlainText));
    PlainText = PlainText - 'a';
    Key = Key -'a';
    Upper_Case = 0;
    counter = 1;
    
    %Since Key-'a' leaves us with -44 = 5 etc, Key(placement) + 49 leaves
    %us with the right value, and we can hardcode the name of the wheel
    %where we want it
    
    LeftWheel = Key(1) + 49;
    LeftWheel = Wheels(LeftWheel-4,:);
    MiddleWheel = Key(2) + 49;
    MiddleWheel = fliplr(Wheels(MiddleWheel-4,:));
    RightWheel = Key(3) + 49;
    RightWheel = Wheels(RightWheel-4,:);
    
    
    for i=1:length(PlainText)
        
        %Checking for special characters and uppercase letters
    
        if (-32 <= PlainText(i)) && (PlainText(i) <=-1)
            PlainText(i) = PlainText(i) + 32;
            Upper_Case = 1;
        else if PlainText(i) < -32
                CipherText(i) = PlainText(i);
                continue;
            end
        end
        
        %Calculating direction and distance of the turn of the wheel
        
        start = find(RightWheel==Key(6));
        stop = find(RightWheel==PlainText(i));
        result = abs(start - stop);
        if stop < start
            result = -(result);
        end
        
       
       %Checking if it should be the left wheel or the middle wheel     
        
        if mod(counter,2) == 1
            counter = counter + 1;
            start = find(LeftWheel==Key(4));
            stop =start + result;
            if stop <= 0
                stop = 26 + stop;
            else if stop > 26;
                    stop = stop - 26;
                end
            end
            if Upper_Case > 0
                CipherText(i) = LeftWheel(stop) - 32;
                Upper_Case = 0;
            else
                CipherText(i) = LeftWheel(stop);
            end
            
            
        else
            counter = counter + 1;
            start = find(MiddleWheel==Key(5));
            stop = start + result;
             if stop <= 0
                stop = 26 + stop;
             else if stop > 26;
                     stop = stop - 26;
                 end
             end
            if Upper_Case > 0
                CipherText(i) = MiddleWheel(stop) - 32;
                Upper_Case = 0;
            else
                CipherText(i) = MiddleWheel(stop);
            end
        

        end
    end
CipherText = char(CipherText +'a');
toc
