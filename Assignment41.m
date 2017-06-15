load seeds.txt

%class to which a seed belongs%
class = zeros(210,1);

%Number of classes%
k = 7; 

%Variables for centroid calculation%
sum_class = zeros(k,7);
count_class = zeros(k,1);

iterations = 0;
sse1 = 0;
sse2 = 0;

%Randomly Generating centroids for K classes%
centroid_class = datasample(seeds,k,'Replace',false);

while iterations < 100
    sse2 = sse1;
    sse1 = 0;
    %Initiating variables needed for centroid to be zero%
    sum_class(:,:) = 0;
    count_class(:,:)=0;
    iterations = iterations + 1;

    for i = 1: 1: 210
        %Intially taking high value for distance%
        error = 1000000;
        for j=1: 1: k
            sum1 = 0 ;
            for l=1: 1: 7
                sum1 = sum1 + (seeds(i,l) - centroid_class(j,l)) * (seeds(i,l) - centroid_class(j,l));
                dist=sqrt(sum1);
            end
            if dist < error
                class(i,1) = j;
                error = dist;
            end
        end
        sse1 = sse1 + (error*error);
    end

    %Centroid calculation in each iteration%
    for i = 1: 1: 210
            for j=1: 1: k
                if class(i,1)==j
                    sum_class(j,:) = sum_class(j,:)+ seeds(i,:);
                    count_class(j,1) = count_class(j,1) + 1;
                end 
            end
    end
    for i = 1: 1: k
        for j = 1: 1: 7
            centroid_class(i,j)=sum_class(i,j)/count_class(i,1);
        end
    end
    if abs(sse2-sse1) < 0.001 
        break
    end
end
disp(sse1);
