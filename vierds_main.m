for i = 1:30
	filename = strcat('input_val',num2str(i),'.yaml')
	vierds(filename,nthprime(i))
end
