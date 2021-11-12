load('Registros/curvaAbsSat.mat');    %Carga datos de curva de absorción
fSamp=6500;                 %Frecuencia de sampleo (Hz)
tSamp=1/fSamp;              %Tiempo de sampleo (s)

Nu0R=25;                   %Offset inicial en frecuencia optica con respecto a Nu_ref (Hz)
Nu0=Nu0R;                   %Frecuencia óptica inicial (Hz)

Aesc=0.12;                   %Amplitud de modulación para ESC
fmod=140;                    %Frecuencia de modulación para ESC (Hz)
tauLock=300e-3;               %Tiempo de integracion en Lock-In
nCut=round(tauLock*fSamp);      %Numero de datos acumulados en demodulación
paramIntegral=ones(1,nCut);
tInitPID=5;            %Tiempo de inicio de PID
Slock=1500;            %Sensitividad de Lock In

tSim=60*5;

Cpzt=33;       % (kHz/V)
Ci=-22.5;      % (MHz/V)

tDAQ=1200*tSamp;
P=-35;      % Inestable
I=1100;     % Inestable


outUnstable = sim('laserESClazoCerrado',tSim);

results = array2table([outUnstable.desarrolloFrecuencia.Time, outUnstable.desarrolloFrecuencia.Data, outUnstable.desarrolloVoltaje.Data, outUnstable.SalidaLockIn.Data, outUnstable.SalidaPI.Data]);
results.Properties.VariableNames(1:5) = {'t','nu','Vpd','Verr','Vpi'};
writetable(results,'Registros/simulacionInestable2.csv')

Nu0R=10; 
P=5;        % Estable
I=300;      % Estable


outEstable = sim('laserESClazoCerrado',tSim);

results = array2table([outEstable.desarrolloFrecuencia.Time, outEstable.desarrolloFrecuencia.Data, outEstable.desarrolloVoltaje.Data, outEstable.SalidaLockIn.Data, outEstable.SalidaPI.Data]);
results.Properties.VariableNames(1:5) = {'t','nu','Vpd','Verr','Vpi'};
writetable(results,'Registros/simulacionEstable2.csv')
