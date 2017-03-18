/*********************************************
 * OPL 12.4 Model
 * Author: haboud910e
 * Creation Date: 7 déc. 2015 at 09:49:22
 *********************************************/
using CP;
/********************/
/* Data declaration */
/********************/
int Nbmorceaux = ...;
range M=1..Nbmorceaux;
{string} Nom=...;
int Duration[M] = ...;
{int} Jouer[n in Nom]=...;
 /**********************/
/* Decision variables */
/**********************/
dvar int x[i in M] in M;// a la position i on joue j 
dvar int y[j in M] in M;// on joue j a la position i
dexpr int f[n in Nom][i in M] = (i>=min(j in M : j in Jouer[n]) y[j]) && (i<=max(j in M : j in Jouer[n])y[j]);
/****************/
/* Search phase */
/****************/

/*execute {
   var z = cp.factory;
   var phase1 = z.searchPhase(x,z.selectSmallest(z.varIndex(x)),z.selectSmallest(z.value()));
   cp.setSearchPhases(phase1,z.searchPhase(y));
   //cp.setSearchPhases(z.searchPhase(y),z.searchPhase(x));
   //cp.param.FailLimit = 1000000;
}*/
/**********************/
/* Objective function */
/**********************/
minimize sum(n in Nom)(sum (i in M) Duration[x[i]]*f[n][i]- sum(i in M : i in Jouer[n])Duration[i]);	
/***************/
/* Constraints */
/***************/
subject to{

	//allDifferent(all(i in M) x[i]);
	inverse(x,y);
	x[1]<x[Nbmorceaux];
}