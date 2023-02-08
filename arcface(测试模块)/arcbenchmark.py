from celeryagedb import main
filename = "genscene/test/329_4_27_0_4_5_-4_0_0_0_0_0_0_0_0_0.bmp"
for i in range(100000):
    main.delay("30","FeatureCompareN","qaiyXHHjcybGzCpPa1iB",filename,"benchmark")
