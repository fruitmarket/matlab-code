#include "compute_rate.h"
#include "mex.h"

#define X_SIZE 144
#define Y_SIZE 96

double build_r_table()
{
  int	i, j, r, n;

  for(r=0; r<400; r++)
    Nr[r] = 0;

  for(i=-20; i<=20; i++)
    for(j=-20; j<20; j++)
      {
		r = i*i + j*j;
		if(r < 400)
		  {
			n = Nr[r];
			Ti[r][n] = i;
			Tj[r][n] = j;
			++Nr[r];
		  }
      }
  return(0.);
}

double compute_rates_place(rate, occ, spikes, alpha, Nx, Ny)
     double		rate[X_SIZE][Y_SIZE];
     double		occ[X_SIZE][Y_SIZE], spikes[X_SIZE][Y_SIZE];
     double		alpha;
     int		Nx, Ny;
{
  int		h, i, j, ii, jj;
  int		r;
  int		occ_count, spike_count;
  Boolean	enough_points;
  
  for(i=0; i<Nx; i++)
    for(j=0; j<Ny; j++)
      if(occ[i][j] == 0)
		rate[i][j] = 0.;
      else
		{
		  enough_points = FALSE;
		  occ_count = spike_count = 1;	/* pretend there's at least one of each */
		  for(r = 0; !enough_points && r<200; r++)
			{
			  for(h=0; h<Nr[r]; h++)
				{
				  ii = i + Ti[r][h];
				  jj = j + Tj[r][h];
				  if(0<=ii && ii<X_SIZE && 0<=jj && jj<Y_SIZE)
					{
					  occ_count += occ[ii][jj];
					  spike_count += spikes[ii][jj];
					}
				}
			  enough_points = (1. < (alpha*alpha*occ_count*occ_count*r*spike_count));
			}
		  if(occ_count < 10)
			rate[i][j] = 0.;
		  else
			rate[i][j] = spike_count/(double)occ_count;
		  }

  return(0.);
}

double occupancy_sparsity(occ, n_occ)
     double	occ[X_SIZE][Y_SIZE];	/* occupancy matrix (length N) */
     int	*n_occ;
{
  int	i, j;
  double	sum2_occ,sum_occ;
  double	sparsity;

  sum_occ = sum2_occ = 0.;
  *n_occ = 0;

  for(i=0; i<X_SIZE; i++)
    for(j=0; j<Y_SIZE; j++)
      if(occ[i][j] > 0)
		{
		  sum_occ += occ[i][j];
		  sum2_occ += occ[i][j]*occ[i][j];
		  ++(*n_occ);
		}
  
  return( (sum_occ*sum_occ)/((*n_occ)*sum2_occ) );
}

double spatial_information(rate, occ, Nx, Ny)
     double	rate[X_SIZE][Y_SIZE];		/* vector of firing rates */
     double	occ[X_SIZE][Y_SIZE];		/* vector of occupancy times */
     int	Nx, Ny;			/* length of vectors */
{
  double	H0, H1, mean_rate;
  double	sum_rate, sum_occ;
  int		j, k;

  H0 = H1 = 0.;
  sum_rate = sum_occ = 0.;
  for(j=0; j<Nx; j++)
    for(k=0; k<Ny; k++)
		if(occ[j][k] > 0)
		{
		  sum_rate += rate[j][k];
		  sum_occ += 1.;
		}

  for(j=0; j<Nx; j++)
    for(k=0; k<Ny; k++)
      if(rate[j][k] > 0.0001)
		{
			H1 += -rate[j][k]*log2(rate[j][k])/sum_occ;
		}

  mean_rate = sum_rate/sum_occ;
  H0 = -mean_rate*log2(mean_rate);
  
  return( (H0 - H1)/mean_rate );
}

double spatial_sparsity(rate, occ, Nx, Ny)
     double	rate[X_SIZE][Y_SIZE];		/* vector of firing rates */
     double	occ[X_SIZE][Y_SIZE];		/* vector of occupancy times */
     int	Nx, Ny;			/* length of vectors */
{
  int	i, j;
  double sum2_rate, sum_rate, sum_occ, mean_rate, mean2_rate;

  sum_rate = sum_occ = sum2_rate = 0.;

  for(i=0; i<Nx; i++)
    for(j=0; j<Ny; j++)
      if(occ[i][j] > 0.)
		{
	      sum_rate += rate[i][j];
	      sum_occ += 1;
	      sum2_rate += rate[i][j]*rate[i][j];
		}
  
  mean_rate = sum_rate/sum_occ;
  mean2_rate = sum2_rate/sum_occ;
  
  return(mean_rate*mean_rate/mean2_rate);
}

int mkr(rate, occ, anal, Nx, Ny, threshold, cutoff, size, icen, jcen, frate, mkr_matrix) 
     double	rate[X_SIZE][Y_SIZE];		/* vector of firing rates */
     double	occ[X_SIZE][Y_SIZE];		/* vector of occupancy times */
     char 	anal[X_SIZE][Y_SIZE];		/* both of size N*N */
     int	Nx, Ny;
     double	threshold;
     int	cutoff;
     double	*size;
     double	*icen, *jcen;
     double	*frate;
     char	mkr_matrix[X_SIZE][Y_SIZE];
{
  int	j, k, xx, yy, largest_field_size, field_size;
  int	pixels_remaining, finished, n_fields;
  double	sum_rate, sum_j, sum_k, sum_bin_spikes, sum_occ;
  double	maxrate;
  int	jmax, kmax;
  Field	*tmp_field;
  
  *size = 0;
  *icen = 0.;
  *jcen = 0.;
  *frate = 0.;

  for(j=0; j<Nx; j++)
    for(k=0; k<Ny; k++)
      {
	if(rate[j][k] > threshold)
	  anal[j][k] = 1;
	else
	  anal[j][k] = 0;
      }
  
  n_fields = 0;
  largest_field_size = 0;
  pixels_remaining = TRUE;
  for(j=0; j<X_SIZE; j++)
    for(k=0; k<Y_SIZE; k++)
      mkr_matrix[j][k] = 0;
  
  
  while(pixels_remaining)
    {
      /* Find first remaining 1pixel */
      finished = FALSE;
      j = k = 0;
      while(anal[j][k] != 1)
	{
	  k++;
	  if(k == Ny)
	    {
	      j++;
	      k = 0;
	    }
	  if( j == Nx )
	    {
	      pixels_remaining = FALSE;
	      break;
	    }
	}
	if(pixels_remaining == FALSE)
	  break;      
      
      /* set pixels in field to 3 */
      anal[j][k] = 2;
      field_size = 0;
      finished = FALSE;
      while( !finished )
	{
	  finished = TRUE;
	  for(j=0; j<Nx; ++j)
	    for(k=0; k<Ny; ++k)
	      if(anal[j][k] == 2)
		{
		  finished = FALSE;
		  anal[j][k] = 3;
		  ++field_size;
		  if(k != 0)
		    if(anal[j][k-1] == 1)
		      anal[j][k-1] = 2;
		  if(k != Ny-1)
		    if(anal[j][k+1] == 1)
		      anal[j][k+1] = 2;
		  if(j != 0)
		    if(anal[j-1][k] == 1)
		      anal[j-1][k] = 2;
		  if(j != Nx-1)
		    if(anal[j+1][k] == 1)
		      anal[j+1][k] = 2;
		}
	}
      
      sum_j = sum_k = sum_rate = sum_bin_spikes = sum_occ = maxrate = 0.;
      for(j=0; j<Nx; ++j)
	for(k=0; k<Ny; ++k)
	  if(anal[j][k] == 3)
	    {
	      sum_j += j*rate[j][k];
	      sum_k += k*rate[j][k];
	      sum_rate += rate[j][k];
	      sum_bin_spikes += rate[j][k]*occ[j][k];
	      sum_occ += occ[j][k];
	      if(rate[j][k] > maxrate)
		{
		  jmax = j;
		  kmax = k;
		  maxrate = rate[j][k];
		}
	    }
      

      if(field_size > largest_field_size) /* calculate stuff */
	{
	  largest_field_size = field_size;
	  *size = largest_field_size;
	  *icen = sum_j/sum_rate;
	  *jcen = sum_k/sum_rate;
	  *frate = sum_bin_spikes/sum_occ;
	}
      
      if(field_size >= cutoff)
	{	
	  mkr_field[n_fields].size = field_size;
	  mkr_field[n_fields].xcen = 4.*sum_j/sum_rate;
	  mkr_field[n_fields].ycen = 4.*sum_k/sum_rate;
	  mkr_field[n_fields].rate = sum_bin_spikes/sum_occ;
	  mkr_field[n_fields].occ = sum_occ;
	  mkr_field[n_fields].xmax = 4.*jmax;
	  mkr_field[n_fields].ymax = 4.*kmax;
	  mkr_field[n_fields].maxrate = maxrate;
	  ++n_fields;
	}
      
      /* Remove the field-pixels from further consideration */
      for(j=0; j<Nx; ++j)
	for(k=0; k<Ny; ++k)
	  if(anal[j][k] == 3)
	    {
	      if(field_size >= cutoff)
		{
		  anal[j][k] = 4;
		  mkr_matrix[j][k] = n_fields;
		}
	      else
		anal[j][k] = 0;
	    }
    }

  /* Now sort MKR fields by size.  Use a simple bubble-sort; inefficient
     but it doesn't really matter because n_fields will never be very large */

  for(j=0; j<n_fields; j++)
    MKR_Field[j] = &mkr_field[j];
  
  for(j=0; j<n_fields-1; j++)
    for(k=0; k<n_fields-1; k++)
      if(MKR_Field[k]->size < MKR_Field[k+1]->size)
	{
	  /* exchange field k and field k+1 */
	  tmp_field = MKR_Field[k];
	  MKR_Field[k] = MKR_Field[k+1];
	  MKR_Field[k+1] = tmp_field;
	}
  
  return(n_fields);
}


void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
	double *Rmap, *Omap, *Smap, *alpha, *mean_rate;
	double *firing_rate_threshold, *mkr_cutoff, *field_info;
	double *features;
    int   map_x, map_y, i, j, column_index;
    double rate_map[X_SIZE][Y_SIZE], occ_map[X_SIZE][Y_SIZE], spike_map[X_SIZE][Y_SIZE];
	double occ_sparsity, info, sparsity;
	double sd_firing_rate, mkr_threshold, largest_field_size;
	double X_center, Y_center, Infield_rate;
	int n_occ, n_fields, field_size_cutoff;
	char	anal[X_SIZE][Y_SIZE], mkr_matrix[X_SIZE][Y_SIZE];

    if(nrhs!=6) 
      mexErrMsgTxt("Six inputs required.");
    else if(nlhs > 3) 
      mexErrMsgTxt("Too many output arguments.");

    map_x = mxGetM(prhs[0]);
    map_y = mxGetN(prhs[0]);

	if ((map_x != X_SIZE) | (map_y != Y_SIZE))
		mexErrMsgTxt("Map size is not 128x96");

	Omap = mxGetPr(prhs[0]);
	Smap = mxGetPr(prhs[1]);
	alpha = mxGetPr(prhs[2]);
	mean_rate = mxGetPr(prhs[3]);
	firing_rate_threshold = mxGetPr(prhs[4]);
	mkr_cutoff = mxGetPr(prhs[5]);
	field_size_cutoff = (int) mkr_cutoff[0];

    plhs[0] = mxCreateDoubleMatrix(map_x,map_y,mxREAL);
    Rmap = mxGetPr(plhs[0]);
	
	column_index = 0;
	for(i=0; i<Y_SIZE; i++){
		for(j=0; j<X_SIZE; j++)
		{
			occ_map[j][i] = Omap[column_index*X_SIZE+j];
			spike_map[j][i] = Smap[column_index*X_SIZE+j];
		}
		column_index += 1;
	}
	build_r_table();
	compute_rates_place(rate_map, occ_map, spike_map,
		alpha[0], X_SIZE, Y_SIZE);
	occ_sparsity = occupancy_sparsity(occ_map, &n_occ);
	info = spatial_information(rate_map, occ_map, map_x, map_y);
	sparsity = spatial_sparsity(rate_map, occ_map, map_x, map_y);

	sd_firing_rate = mean_rate[0]*sqrt(1./sparsity - 1.);
	mkr_threshold = mean_rate[0] + firing_rate_threshold[0]*sd_firing_rate;

	n_fields = mkr(rate_map, occ_map, anal, map_x, map_y, mkr_threshold,
		field_size_cutoff, &largest_field_size, &X_center, &Y_center,
		&Infield_rate, mkr_matrix);
	column_index = 0;
	for(i=0; i<Y_SIZE; i++){
		for(j=0; j<X_SIZE; j++)
			Rmap[column_index*X_SIZE+j] = rate_map[j][i];
		column_index += 1;
	}
	plhs[1] = mxCreateDoubleMatrix(2, 1,mxREAL);
	features = mxGetPr(plhs[1]);
	features[0] = info;
	features[1] = (double)n_fields;

	if(n_fields > 0)
	{
		plhs[2] = mxCreateDoubleMatrix(8, n_fields, mxREAL);
		field_info = mxGetPr(plhs[2]);
		for(i=0;i<n_fields;i++)
		{
			field_info[8*i+0] = mkr_field[i].size;
			field_info[8*i+1] = mkr_field[i].xcen;
			field_info[8*i+2] = mkr_field[i].ycen;
			field_info[8*i+3] = mkr_field[i].rate;
			field_info[8*i+4] = mkr_field[i].occ;
			field_info[8*i+5] = mkr_field[i].xmax;
			field_info[8*i+6] = mkr_field[i].ymax;
			field_info[8*i+7] = mkr_field[i].maxrate;
		}
		
	}
	else
	{
		plhs[2] = mxCreateDoubleMatrix(8, 1, mxREAL);
		field_info = mxGetPr(plhs[2]);
		field_info[0] = 0.0;
	}
}