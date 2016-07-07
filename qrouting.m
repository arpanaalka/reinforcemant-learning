clc;
close all;
clear all;

eta=0.1
s1=0.005 %5ms transmission time b/w any two nodes
eps=exp(-3)
dest=6

 field1= 'no';
 value1=[];
field2='adj_nodes';
value2={zeros(1,3)};
field3='adj_cost';
 value3={zeros(1,3)};
 field4='q';
value4={rand(1,12)};
 field5='qDelay';
value5=rand(1);
 for i=1:12
s(i)= struct(field1,value1,field2,value2,field3,value3,field4,value4,field5,value5);
s(i).no=i;
s(i).q(i)=0;
 end
 
s(1).adj_nodes = [2,5,0];
s(1).q(2)=1;
s(1).q(5)=1;
s(1).adj_costs=[0,0,-1.0];

s(2).adj_nodes = [1,0,0];
s(2).q(1)=1;
s(2).adj_costs=[0,-1,-1.0];

s(3).adj_nodes = [4,0,0];
s(3).q(4)=1;
s(3).adj_costs=[0,-1,-1.0];

s(4).adj_nodes = [3,8,0];
s(4).q(3)=1;
s(4).q(8)=1;
s(4).adj_costs=[0,0,-1.0];

s(5).adj_nodes = [1,6,9];
s(5).q(1)=1;
s(5).q(6)=1;
s(5).q(9)=1;
s(5).adj_costs=[0,0,0];

s(6).adj_nodes = [5,7,0];
s(6).q(5)=1;
s(6).q(7)=1;
s(6).adj_costs=[0,0,-1.0];


s(7).adj_nodes = [6,8,0];
s(7).q(6)=1;
s(7).q(8)=1;
s(7).adj_costs=[0,0,-1.0];

s(8).adj_nodes = [4,7,12];
s(8).q(4)=1;
s(8).q(7)=1;
s(8).q(12)=1;
s(8).adj_costs=[0,0,0];

s(9).adj_nodes = [5,10,0];
s(9).q(5)=1;
s(9).q(9)=1;
s(9).adj_costs=[0,0,-1.0];

s(10).adj_nodes = [9,11,0];
s(10).q(9)=1;
s(10).q(11)=1;
s(10).adj_costs=[0,0,-1.0];

s(11).adj_nodes = [10,12,0];
s(11).q(10)=1;
s(11).q(12)=1;
s(11).adj_costs=[0,0,-1.0];

s(12).adj_nodes = [8,11,0];
s(12).q(6)=1;
s(12).q(8)=1;
s(12).adj_costs=[0,0,-1.0];

episode=0;
counter=0;
old_next_list=zeros(1,12);
new_next_list=zeros(1,12);

while(1)
    for i=1:12
         adj = s(i).adj_nodes;
         indx = 1;
         dest_cost=zeros(1,4);
         j=1
         x=0;
         while adj(indx)~=0
             dest_cost(j) = s(adj(indx)).q(dest)
             if dest_cost(j)~=0
                 x=x+1
             end
             indx=indx+1;
             j=j+1
             if indx==4
                    break
             end
         end
         
         
         [t,ind]=min(dest_cost(1:x));
         dest_cost
         t
         ind
         next = adj(ind);
         next
         new_next_list(i) = next;
         minNext=s(next).q(dest);
         deltaQ=eta*(s(i).qDelay+s1+minNext - s(i).q(dest));
         s(i).q(dest)=s(i).q(dest)+deltaQ;
    end
 
    
    if norm(new_next_list-old_next_list) < eps
        counter = counter+1
    else
        counter=0
    end
    
    if counter > 10
        break
    end
    episode = episode+1
    if episode > 100
        break
    end
	old_next_list=new_next_list;
end

disp('final route to destination'),disp(dest)
for i=1:12
	if (i~=dest)
		X = ['next node for ',num2str(i),' is ',num2str(new_next_list(i))];
		disp(X)
		%disp('next node for '),disp(i),disp(new_next_list(i));
    end
end
    
