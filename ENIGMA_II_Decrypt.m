
function PlainText = ENIGMA_II_Encrypt(CipherText,Key)


    %Defining the wheels as an array
    Wheels = ['abcdefghijklmnopqrstuvwxyz';'acedfhgikjlnmoqprtsuwvxzyb';'azyxwvutsrqponmlkjihgfedcb'];
    Wheels = Wheels - 'a';
    
    %Defining variables
    PlainText = (1:length(CipherText));
    CipherText = CipherText - 'a';
    Key = Key -'a';
    Upper_Case = 0;
    counter = 1;
    
    
    %Since Key-'a' leaves us with -44 = 5 etc, Key(placement) + 49 leaves
    %us with the right value, and we can hardcode the name of the wheel
    %where we want it instead of mabye getting errors
    
    LeftWheel = Key(1) + 49;
    LeftWheel = Wheels(LeftWheel-4,:);
    MiddleWheel = Key(2) + 49;
    MiddleWheel = fliplr(Wheels(MiddleWheel-4,:));
    RightWheel = Key(3) + 49;
    RightWheel = Wheels(RightWheel-4,:);
    
    
    for i=1:length(CipherText)
        
        %Checking for special characters and uppercase letters
        
        if (-32 <= CipherText(i)) && (CipherText(i) <=-1)
            CipherText(i) = CipherText(i) + 32;
            Upper_Case = 1;
        else if CipherText(i) < -32
                PlainText(i) = CipherText(i);
                continue;
            end
        end
        
        %Checking if it should be the left wheel or the middle wheel   
        
        if mod(counter,2) == 1
            counter = counter + 1;
            start = find(LeftWheel==Key(4));
            stop = find(LeftWheel==CipherText(i));
             result = abs(start - stop);
        if stop < start
            result = -(result);
        end
        else
            counter = counter + 1;
            start = find(MiddleWheel==Key(5));
            stop = find(MiddleWheel==CipherText(i));
             result = abs(start - stop);
        if stop < start
            result = -(result);
        end
        end
        
        %Calculating plaintext
        
        start = find(RightWheel==Key(6));
            stop = start + result;
             if stop <= 0
                stop = 26 + stop;
             else if stop > 26
                     stop = stop - 26;
                 end
             end
             if Upper_Case > 0
                PlainText(i) = RightWheel(stop) - 32;
                Upper_Case = 0;
            else
                PlainText(i) = RightWheel(stop);
            end
            
    end
PlainText = char(PlainText +'a');
