// Point to point network test with MPI.
// Compile with the command:
//>mpiicc -std=c99 point.c

#include <mpi.h>
#include <sys/time.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int main(int argc, char **argv )
{
   MPI_Init(&argc, &argv);
   int myinst, nproc;
   MPI_Comm_rank(MPI_COMM_WORLD, &myinst);
   MPI_Comm_size(MPI_COMM_WORLD, &nproc);
   MPI_Status status;
   double s=0.;

   int namelen;
   char processor_name[MPI_MAX_PROCESSOR_NAME];
   MPI_Get_processor_name(processor_name, &namelen);
   printf("Process %d of %d on %s\n", myinst, nproc, processor_name);

   for(int repA = 1000; repA < 10000; repA*=2)
     if (myinst == 0) {
       MPI_Recv(&s, 1, MPI_DOUBLE, 1, 1, MPI_COMM_WORLD, &status);
       //printf(" Slave a testui pasiruoses \n");

       double start = MPI_Wtime();
       for (int i = 0; i < repA; i++) {
         MPI_Send( &s, 1, MPI_DOUBLE, 1, 2*i, MPI_COMM_WORLD);
         MPI_Recv(&s, 1, MPI_DOUBLE, 1, 2*i+1,MPI_COMM_WORLD, &status);
       }
       double stop = MPI_Wtime();
       double alpha = (stop - start)/(2.*repA);
       printf("%d times alpha = %e \n", repA, alpha);
     }
     else if (myinst == 1){
       MPI_Send( &s, 1, MPI_DOUBLE, 0, 1, MPI_COMM_WORLD);
       for (int i = 0; i < repA; i++) {
         MPI_Recv(&s, 1, MPI_DOUBLE, 0, 2*i,MPI_COMM_WORLD, &status);
         MPI_Send( &s, 1, MPI_DOUBLE, 0, 2*i+1, MPI_COMM_WORLD);
       }
     }

   for(int Nsend = 100; Nsend < 1000001; Nsend*=10){

     int repB = 1000;
     double* darray = (double *)malloc(2*Nsend * sizeof(double));
     if (myinst == 0) {

       MPI_Recv(&s, 1, MPI_DOUBLE, 1, 1, MPI_COMM_WORLD, &status);
       //printf(" Slave b testui pasiruoses \n");
       double Laikas[2]; 
       for(int k=1; k < 3; k++)
       {
         double start = MPI_Wtime();
         for (int i = 0; i < repB; i++) {
           MPI_Send( darray, k*Nsend, MPI_DOUBLE, 1, 2*i, MPI_COMM_WORLD);
           MPI_Recv( darray, k*Nsend, MPI_DOUBLE, 1, 2*i+1,MPI_COMM_WORLD, &status);
         }
         double stop = MPI_Wtime();
         Laikas[k-1] = stop - start;
       }
       double beta = (Laikas[1]-Laikas[0])/(2.*repB*Nsend);
       printf("Nsend(2) = %d  beta = %e, bandwidth = %e \n", Nsend, beta, 64./beta);
     }
     else if (myinst == 1){
 
       MPI_Send( &s, 1, MPI_DOUBLE, 0, 1, MPI_COMM_WORLD);
       for(int k=1; k < 3; k++)
       {
         for (int i = 0; i < repB; i++) {
           MPI_Recv( darray, k*Nsend, MPI_DOUBLE, 0, 2*i,MPI_COMM_WORLD, &status);
           MPI_Send( darray, k*Nsend, MPI_DOUBLE, 0, 2*i+1, MPI_COMM_WORLD);
         }
       }
     }
     free(darray);
   }

   MPI_Finalize();
   return 0;
}
