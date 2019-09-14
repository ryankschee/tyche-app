
function tycheesMath_round(value, decimals) {
	if (typeof value !== 'number')
		return 0;
	
	return Number(Math.round(value+'e'+decimals)+'e-'+decimals);
} // .end of tycheesMath_round