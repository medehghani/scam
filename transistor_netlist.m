clear all
%example
% Q3 6 3 0 my-npn
fname="BJT_1.cir";

%% Print out the netlist (a file describing the circuit with one circuit
% per line.
fprintf('Netlist:');
type(fname)
fid = fopen(fname);
fileIn=textscan(fid,'%s %s %s %s %s %s');  % Read file (up to 6 items per line
% Split each line into 6 columns, the meaning of the last 3 columns will
% vary from element to element.  The first item is always the name of the
% circuit element and the second and third items are always node numbers.
[Name, N1, N2, arg3, arg4, arg5] = fileIn{:};
% Name, node1, node2, and up to three other arguments.
fclose(fid);

nLines = length(Name);  % Number of lines in file (or elements in circuit).


%% 2

qlines = [];
nQ = 0;
lines(nLines) = "";
% % Rpi = [];
% Ro = [];
% % Rpi = [];
% GQ = [];

% Scan Lines for "Models"
for k1=1:nLines
    n1 = N1(k1);   % Get the two node numbers
    n2 = N2(k1);
    
    switch Name{k1}(1)
        % Passive element
        case 'Q'
            n3 = (arg3{k1});  % This find n3
            tag = Name{k1}(2:end);
            nQ = nQ + 1;
            disp("Found One "+ tag)
            qlines = [qlines k1];
            
            % Small Signal model of BJT transistor
            
            % Rpi_tag   N2   N3   Symbolic
            % Ro_tag   N1   N3   Symbolic
            % GQ_tag    N1   N3   N2   N3   gm_tag
 
             rpi(nQ) = sprintf("Rpi_%s %s %s Symbolic", tag, n2{1}, n3);
             ro(nQ) = sprintf("Ro_%s %s %s Symbolic", tag, n1{1}, n3);
             gq(nQ) = sprintf("Rpi_%s %s %s %s %s Symbolic", tag, n1{1}, n3, n2{1}, n3);
        otherwise
            
            lines(k1) = join([Name{k1}, N1{k1}, N2{k1}, arg3{k1}, arg4{k1}, arg5{k1}, ""], " ");
            
    end
end

lines = [lines, rpi, ro, gq];

lines_chars = convertStringsToChars(lines);
lines_chars(strcmp('',lines_chars)) = [];

filePh = fopen('output.test','w');
fprintf(filePh,'%s\n',lines_chars{:});
fclose(filePh);


% Rebuild File
% Scan Lines for "Models"
% for k1=1:nLines
%     n1 = N1(k1);   % Get the two node numbers
%     n2 = N2(k1);
%
%     switch Name{k1}(1)
%         % Passive element
%         case 'Q'
%             n3 = str2double(arg3{k1});  % This find n3
%             tag = Name{k1}(2:end);
%             nQ = nQ + 1;
%             disp("Found One "+ tag)
%             qlines = [qlines k1];
%
%             % Small Signal model of BJT transistor
%
%             % Rpi_tag   N2   N3   Symbolic
%             Rpi(nQ,:) = {join(['Rpi_', tag]), n2, n3, 'Symbolic'};
%             % Ro_tag   N1   N3   Symbolic
%             Ro(nQ,:) = {join(['Ro_', tag]), n1, n3, 'Symbolic'};
%             % GQ_tag    N1   N3   N2   N3   gm_tag
%             GQ(nQ,:) = {join(['GQ_', tag]), n1, n3, n2, n3, 'Symbolic'};
%
%     end
% end
