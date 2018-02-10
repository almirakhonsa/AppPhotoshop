function varargout = Photoshop(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Photoshop_OpeningFcn, ...
                   'gui_OutputFcn',  @Photoshop_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
  
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function Photoshop_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = Photoshop_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% function browser
function pushbutton1_Callback(hObject, eventdata, handles)
[Filename, PathName] = uigetfile('*', 'Select Image File');
im = imread([PathName, Filename]);
set(handles.edit4,'String' ,Filename);
handles.im = im;
guidata(hObject, handles);
axes(handles.axes1);
imshow(im);

% button group rotasi 90
function rotasi90_CreateFcn(hObject, eventdata, handles)

function rotasi90_SelectionChangedFcn(hObject, eventdata, handles)
get(eventdata.NewValue, 'Tag');

% fungsi rotate kelipatan 90
function pushbutton4_Callback(hObject, eventdata, handles)
opt = get(handles.rotasi90, 'SelectedObject');
degree = str2double(get(opt,'String'));
A = getimage(handles.axes1);
if degree == 90
    for h=1:size(A,3)
        for i=1:size(A,1)
            c = size(A,2);
            for j=1:size(A,2)
                img(c,i,h) = A(i,j,h);
                c = c-1;
            end
        end
    end
elseif degree == 180
    for h=1:size(A,3)
        r = size(A,1);
        for i=1:size(A,1)
            c = size(A,2);
            for j=1:size(A,2)
                img(r,c,h) = A(i,j,h);
                c = c-1;
            end
            r = r-1;
        end
    end
elseif degree == 270
    for h=1:size(A,3)
        for i=1:size(A,1)
            c = size(A,2);
            for j=1:size(A,2)
                img(c,i,h) = A(i,j,h);
                c = c-1;
            end
        end
    end
end
handles.im = img;
guidata(hObject, handles);
axes(handles.axes1);
imshow(img);  

% fungsi flipping
function pushbutton9_Callback(hObject, eventdata, handles)
opt = get(handles.flipping, 'SelectedObject');
opt = str2double(get(opt,'String'));
A = getimage(handles.axes1);
% if opt == 1
%     N = A;
%     for m=1:size(A,3)
%         k = size(A,1);
%         for i=1:size(A,1)
%             for j=1:size(A,2)
%                 N(k,j,m) = A(i,j,m);
%             end
%             k = k-1;
%         end
%     end
if opt == 1
    N = A;
    for m=1:size(A,3) % 3 dimensi
        for i=1:size(A,1) % baris
            k = size(A,2); % kolom
            for j=1:size(A,2) % kolom
                N(i,k,m) = A(i,j,m);
            end
            k = k-1;
        end
    end
elseif opt == 2
    for m=1:size(A,3)
        k = size(A,2);
        for i=1:size(A,2)
            for j=1:size(A,1)
                N(j,k,m) = A(j,i,m);
            end
            k = k-1;
        end
    end
end
handles.im = N;
guidata(hObject, handles);
axes(handles.axes1);
imshow(N);

% fungsi save 
function pushbutton10_Callback(hObject, eventdata, handles)
axes(handles.axes1);
A = getimage(handles.axes1);
[Filename, PathName] = uiputfile('*.jpg', 'Save As');
Fname = fullfile(PathName, Filename);
set(handles.edit4,'String',Filename);
imwrite(A, Fname, 'jpg');

% fungsi tampilkan resolusi
function pushbutton11_Callback(hObject, eventdata, handles)
Filename = get(handles.edit4,'String');
info = imfinfo(Filename);
formatSpec = '%dx%d';
w = info.Width;
h = info.Height;
Resolution = sprintf(formatSpec,w,h)
set(handles.edit7,'String',Resolution);

% fungsi zoom
function pushbutton6_Callback(hObject, eventdata, handles)
A = getimage(handles.axes1);
n = str2double(get(handles.edit2,'String'));
baris = (size(A,1))*n;
kolom = (size(A,2))*n;
for z=1:3
    for r=1:baris
        b = ((r-1)/n)+1;
        for c=1:kolom
            k = ((c-1)/n)+1;
            N(r,c,z) = A(floor(b),floor(k),z);
        end
    end
end
handles.im = N;
guidata(hObject, handles);
axes(handles.axes1);
imshow(N);

function edit6_Callback(hObject, eventdata, handles)

function edit6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function flipping_CreateFcn(hObject, eventdata, handles)

function flipping_SelectionChangedFcn(hObject, eventdata, handles)
get(eventdata.NewValue, 'Tag');

function radiobutton11_Callback(hObject, eventdata, handles)

function pushbutton2_Callback(hObject, eventdata, handles)

function pushbutton3_Callback(hObject, eventdata, handles)

function pushbutton7_Callback(hObject, eventdata, handles)

function edit7_Callback(hObject, eventdata, handles)

function edit7_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit8_Callback(hObject, eventdata, handles)

function edit8_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit5_Callback(hObject, eventdata, handles)

function edit5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit4_Callback(hObject, eventdata, handles)

function edit4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit2_Callback(hObject, eventdata, handles)

function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit3_Callback(hObject, eventdata, handles)

function edit3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton12_Callback(hObject, eventdata, handles)

% tampilkan histogram
function pushbutton13_Callback(hObject, eventdata, handles)
A = getimage(handles.axes1);
h = zeros(256,1);
R = A(:,:,1);
G = A(:,:,2);
B = A(:,:,3);
for r=1:size(A,1)
    for c=1:size(A,2)
        nilai = A(r,c)+1;
        h(nilai,1) = h(nilai,1)+1;
    end
end
Horis = (0:255)';
bar(Horis, h);

function axes4_CreateFcn(hObject, eventdata, handles)

% equalisasi
function pushbutton14_Callback(hObject, eventdata, handles)
A = getimage(handles.axes1);
A = double(A);
trans = zeros(256,6);

for row=1:size(A,1)
    for col=1:size(A,2)
        for j=1:256
            if A(row,col) == (j-1)
                trans(j,1) = (j-1)/255;
                trans(j,2) = trans(j,2)+1;
            end
        end
    end
end
n = sum(trans(:,2));
for k=1:256
    trans(k,3) = trans(k,2)/n;
    jum = 0;
    for l=1:k
        jum = jum + trans(l,3);
    end
    trans(k,4) = jum;
    trans(k,5) = round(trans(k,4)*255);
    trans(k,6) = trans(k,5)/255;
end
for row=1:size(A,1)
    for col=1:size(A,2)
        A(row,col) = trans((A(row,col))+1,5);
    end
end
imshow(uint8(A));

% spesifikasi
function pushbutton15_Callback(hObject, eventdata, handles)
A = getimage(handles.axes1);
A = double(A);
% histogram yang diinginkan
Z = double(A);
for r=1:size(Z,1)
    for c=1:size(Z,2)
        if Z(r,c) >= 240
            Z(r,c) = 0;
        end
    end
end

% equalisasi histogram
trans = zeros(256,9);
for row=1:size(A,1)
    for col=1:size(A,2)
        for j=1:256
            if A(row,col) == (j-1)
                trans(j,1) = (j-1)/255;
                trans(j,2) = trans(j,2)+1;
            end
        end
    end
end
n = sum(trans(:,2));
for k=1:256
    trans(k,3) = trans(k,2)/n;
    jum = 0;
    for l=1:k
        jum = jum + trans(l,3);
    end
    trans(k,4) = jum;
    trans(k,5) = round(trans(k,4)*255);
    trans(k,6) = trans(k,5)/255;
end

% equalisasi histogram yang diinginkan
transf = zeros(256,6);
for row=1:size(Z,1)
    for col=1:size(Z,2)
        for j=1:256
            if Z(row,col) == (j-1)
                transf(j,1) = (j-1)/255;
                transf(j,2) = transf(j,2)+1;
            end
        end
    end
end
n = sum(transf(:,2));
for k=1:256
    transf(k,3) = transf(k,2)/n;
    jum = 0;
    for l=1:k
        jum = jum + transf(l,3);
    end
    transf(k,4) = jum;
    transf(k,5) = round(transf(k,4)*255);
    transf(k,6) = transf(k,5)/255;
end

for k=1:256
    trans(k,7) = round(transf(k,4));
    trans(k,8) = round(trans(k,7)*255); 
    trans(k,9) = trans(k,8)/255;
end

for row=1:size(A,1)
    for col=1:size(A,2)
        A(row,col) = trans((A(row,col))+1,9);
    end
end
imshow(A);

% mean median modus filtering
function pushbutton16_Callback(hObject, eventdata, handles)
opt = get(handles.smoothing, 'SelectedObject');
opt = str2double(get(opt,'String'));
I = getimage(handles.axes1);
r = size(I,1);
c = size(I,2);
A = double(I);
if opt == 1
    for k=1:3
        for i=2:r-1
            for j=2:c-1
                jumlah = A(i-1,j-1,k)+ A(i-1,j,k)+ A(i-1,j+1,k)+ A(i,j-1,k)+ A(i,j,k)+ A(i,j+1,k)+ A(i+1,j-1,k)+ A(i+1,j,k)+ A(i+1,j+1,k);
                G(i,j,k) = uint8(jumlah * 1/9);
            end
        end
    end
elseif opt == 2
    for k=1:3
        for i=2:r-1
            for j=2:c-1
                tetangga = [A(i-1,j-1,k) A(i-1,j,k) A(i-1,j+1,k) A(i,j-1,k) A(i,j,k) A(i,j+1,k) A(i+1,j-1,k) A(i+1,j,k) A(i+1,j+1,k)];
                tetanggasort = sortrows(tetangga');
                G(i,j,k) = uint8(tetanggasort(5));
            end
        end
    end
elseif opt == 3
    for k=1:3
        for i=2:r-1
            for j=2:c-1
                tetangga = [A(i-1,j-1,k) A(i-1,j,k) A(i-1,j+1,k) A(i,j-1,k) A(i,j,k) A(i,j+1,k) A(i+1,j-1,k) A(i+1,j,k) A(i+1,j+1,k)];
                tetanggasort = sortrows(tetangga');
                for m=1:9
                    o = 0;
                    for n=1:9
                        if tetanggasort(n,1) == tetanggasort(m,1)
                            o = o + 1;
                        end
                    end
                    N(1,m) = o;
                end
                transform = tetanggasort';
                [M, I] = max(N(:));
                [i_row, i_col] = ind2sub(size(N),I);
                modus = transform(i_row,i_col);
                G(i,j,k) = uint8(modus);
            end
        end
    end
end
figure(1);
imshow(G);

% grup smoothing
function smoothing_CreateFcn(hObject, eventdata, handles)

function smoothing_SelectionChangedFcn(hObject, eventdata, handles)
get(eventdata.NewValue, 'Tag');


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
I = getimage(handles.axes1);
r = size(I,1);
c = size(I,2);
A = double(I);
for k=1:3
    for i=2:r-1
        for j=2:c-1
            jumlah = A(i-1,j-1,k)+ A(i-1,j,k)+ A(i-1,j+1,k)+ A(i,j-1,k)+ A(i,j,k)+ A(i,j+1,k)+ A(i+1,j-1,k)+ A(i+1,j,k)+ A(i+1,j+1,k);
            G(i,j,k) = uint8(jumlah * 1/9);
        end
    end
end
figure(1);
imshow(G);

function pushbutton6_ButtonDownFcn(hObject, eventdata, handles)

% edge detection dengan menggunakan sobel
function pushbutton18_Callback(hObject, eventdata, handles)
A = getimage(handles.axes1);
A = double(A);
r = size(A,1);
c = size(A,2);
F = zeros(r,c);
for r=1:size(A,1)
    for c=1:size(A,2)
        if A(r,c) >= 100
            A(r,c) = 0;
        else
            A(r,c) = 1;
        end
    end
end
for i=2:r-1
    for j=2:c-1
        F(i,j) = sqrt((A(i-1, j-1) + 2*A(i, j-1) + A(i+1, j-1) - A(i-1, j+1) + 2*A(i, j+1) + A(i+1, j+1))^2) + (A(i+1, j-1) + 2*A(i+1, j) + A(i+1, j+1) - A(i-1, j-1) + 2*A(i-1, j) + A(i-1, j+1)^2);
    end
end
imshow(uint8(F))
