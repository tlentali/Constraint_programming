/*********************************************
 * OPL 12.6.0.0 Model
 * Author: Comoria
 * Creation Date: 25 nov. 2015 at 18:54:19
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
dvar interval x[i in M] in 0..sum(i in M)Duration[i] size Duration[i];//x["Joueura"][n] represente l'interval du joueur a pour le morceaux n
dvar interval y[n in Nom];
dvar sequence p in x;
/****************/
/* Search phase */
/****************/

execute {
   var f = cp.factory;
   cp.setSearchPhases(f.searchPhase(x),f.searchPhase(y));
   //cp.param.FailLimit = 1000000;
}
/**********************/
/* Objective function */
/**********************/
minimize sum(n in Nom)(lengthOf(y[n]) - sum(i in M : i in Jouer[n])Duration[i]);
/***************/
/* Constraints */
/***************/
subject to {
	forall(n in Nom){
		span(y[n],all(i in M : i in Jouer[n]) x[i]);
	}
	noOverlap(p);
	before(p,x[4],x[7]);    
	/*forall(i in M){
		synchronize(x["Joueur1"][i],all(n in Nom)x[n][i]);	
	}*/
}