function r=distance(params)   
    global h
    J=params(1);            
    b=params(2);            
    K=params(3);
    R=params(4);            
    L=params(5);
    A=[-b/J K/J; -K/L R/L];
    B=[0;1/L];
    C=[1,0];
    D=0;
    
    if sum(real(eig(A))>=0)>0
        r=inf
    else
    
    sys=ss(A,B,C,D);
 
    sysd=c2d(sys,h);
    global u 
    global t 
    global y   
    [y_model,t]=lsim(sysd,u,t);
    r=norm(y(500:end)-y_model(500:end))
    hold off
    plot(t,u,'k')
    hold on
    plot(t,y,'r')
    plot(t,y_model,'b')
    drawnow()
    end
end