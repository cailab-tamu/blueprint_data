a=[14549
13733
32296
7539
33672
463156
622270
455685
315140
343296
529428
363028
370441
352588
329681
457714
785785
315654
323527
322324
446960
307844
464458
326704
488408
302676
288600
723615
362799
247761
470007
263728
796105
550619
1018947
1136308
468459
1000436
763769
1896395
409761
815783
830749
592719
490043
368147
420651
363924
1158110
283097
971044
646319
426044
411020
542262
508871
544937
559915
254216
599590
426524
369689
282115
525390
471388
825927
587978
520081
278406
405084
330662
833914
484715
838948
322794
443852
786793
272188
407686
394106
371410
684785
248436
357129
363721
1456756
314172
334740
364451
444163
456621
619089
438887
536539
271417
443197
638584
922096
212226
514857
439296
702490
603048
454401
427342
275088
958772
224696
320914
357123
328208
241875
567122
398572
493767
325848
412954
310610
379682
319651
321755
413983
302439
233650
455379
245587
274467
526135
342263
604960
441377
575772
269278
527622
505351
339283
295616
126333
635400
534219
232606
265925
605387
497917
410506
348178];

stem(sort(a))
find(abs(zscore(sort(a)))>1.5)
