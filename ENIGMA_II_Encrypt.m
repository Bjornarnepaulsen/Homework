
function ciphertext = ENIGMA_II_Encrypt(text,key)
    %Defining the wheels
    Wheel_5 = double(('abcdefghijklmnopqrstuvwxyz'));
    Wheel_6 = double(('acedfhgikjlnmoqprtsuwvxzyb'));
    Wheel_7 = double(('azyxwvutsrqponmlkjihgfedcb'));
    
    %Defining ciphertext
    ciphertext = [1:length(text)];
    
    for i=1:length(text)
        %Wheel = strcat('Wheel_',key(3));
        double(text(i))
        result = find(Wheel_7==double(text(i)))
        result = abs(key(6)-result)
        if mod(i,2) == 1
         %   Wheel = strcat('Wheel_',key(1))
            ciphertext = strcat(ciphertext(i),Wheel_5(abs(key(4)-result)))
        else
        %    Wheel = strcat('Wheel_',key(2))
            ciphertext = strcat(ciphertext(i),Wheel_6(abs(key(5)+result)));
       
   
        
    
        end
        
        CipherText = char(ciphertext)
        
end