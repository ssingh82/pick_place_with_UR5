function Msg = readrobotMsg(t)
Msg = fscanf(t,'%c',t.BytesAvailable);
end