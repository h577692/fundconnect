function geodata

% SIMPLE_GUI2 Select a data set from the pop-up menu and display
f = figure('Position',[400,400,600,500]);
h = [];

% Assure resize automatically.
f.Units = 'normalized';    set(h, 'Units', 'normalized');
set(h, 'FontSize', 12);

%% Construct the components.
% data
h(1) = uicontrol('Style','popupmenu',...
    'String',{'Peaks','Membrane','Sinc', 'Hi'},...
    'Position',[450,400,100,25],...
    'Callback',@popup_menu_Data);

h(2) = axes('Units','pixels','Position',[50,30,355,355]);
% start
h(3) = uicontrol('Style','pushbutton',...
    'String','Start',...
    'Position',[450,325,52,25],...
    'Callback',@startRotate);
% stop
h(4) = uicontrol('Style','pushbutton',...
    'String','Stop',...
    'Position',[500,325,52,25],...
    'Callback',@stopRotate);
% view
h(5) = uicontrol('Style','popupmenu',...
    'String',{'Default','Top','Front','Side'},...
    'Position',[450,375,100,25],...
    'Callback',@popup_menu_View);
% single rotate
h(6) = uicontrol('Style','pushbutton',...
    'String','Rotate',...
    'Position',[450,350,100,25],...
    'Callback',@singleRotate);

% animate
h(7) = uicontrol('Style','pushbutton',...
    'String','Animate',...
    'Position',[450,300,100,25],...
    'Callback',@animateFigure);

%% Generate the data to plot.
peaks_data = peaks(35);
membrane_data = membrane;
[x,y] = meshgrid(-8:.5:8);
r = sqrt(x.^2+y.^2) + eps;
sinc_data = sin(r)./r;

x = linspace(-3,3,50);
y = linspace(-5,5,50);
[X, Y]=meshgrid(x,y);
Z = exp(-X.^2-Y.^2/2).*cos(4*X) + exp(-3*((X+0.5).^2+Y.^2/2));
Z(Z>0.001)=0.001;
Z(Z<-0.001)=-0.001;
hi_data = Z;

%% misc
% Create a plot in the axes.
current_data = peaks_data;
s = surf(current_data);

% timer for rotasjon
tmr = timer('ExecutionMode', 'FixedRate', ...
    'Period', 0.2, ...
    'TimerFcn', @(~,~)timerCallback);

% lyd
[xG,fs] = audioread('fundconnect.mp3');
recG = audioplayer(xG, fs);
axis auto;
view([-40 30]);

%%  functions
% data meny
    function popup_menu_Data(source,~)
        stop(tmr);
        % Determine the selected data set.
        str = get(source, 'String');
        val = get(source,'Value');
        
        % Set current data to the selected data set.
        switch str{val}
            case 'Peaks'
                % User selects Peaks.
                current_data = peaks_data;
            case 'Membrane'
                current_data = membrane_data;
            case 'Sinc'
                current_data = sinc_data;
            case 'Hi'
                current_data = hi_data;
        end
        
        s = surf(current_data);
    end
% view meny
    function popup_menu_View(source,~)
        stop(tmr);
        % Determine the selected data set.
        str = get(source, 'String');
        val = get(source,'Value');
        
        % Set current data to the selected data set.
        switch str{val}
            case 'Default'
                % User selects Peaks.
                view([-40 30]);
            case 'Top'
                view([0 90]);
            case 'Front'
                view([-90 0]);
            case 'Side'
                view([0 0]);
        end
        
    end

    function timerCallback(~,~)
        
        rotate(s, [0 0 1], 5);
    end

% rotate start
    function startRotate(~,~)
        axis manual;
        start(tmr);
        play(recG);
    end

% rotate stop
    function stopRotate(~,~)
        axis auto;
        stop(tmr);
        stop(recG);
    end

% single rotate
    function singleRotate(~,~)
        rotate(s, [0 0 1], 5);
    end
% animate
    function animateFigure(~,~)
        axis vis3d off;
        for xi = -400:5:400
            campos([xi,5,10])
            camroll(1);
            drawnow
            pause(0.05);
        end
        axis vis3d on;
    end
end