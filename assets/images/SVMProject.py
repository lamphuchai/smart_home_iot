import os
import cv2
import joblib
import numpy as np
import matplotlib.pyplot as plt
from skimage import feature
from sklearn import metrics
from sklearn.svm import LinearSVC, SVC

radius = 2
n_points = 8 * radius

dir_train = "/home/duc/Desktop/ML/FacesTrain"
dir_test = "/home/duc/Desktop/ML/FacesTest"
dir_model = "/home/duc/Desktop/ML/model"

categories = [
              'Ali_HoangDuong', 'Angela_Phuong_Trinh', 'An_Nguy', 'Bao_Anh', 'Bao_Lam',
              'Bao_Thi', 'Bich_Phuong', 'Binz', 'Cam_Ly', 'Chi_Dan',
              'Chi_Pu', 'Chi_Thien', 'Dam_Vinh_Hung', 'Dan_Truong', 'Diep_Lam_Anh',
              'Dieu_Nhi', 'Dinh_Huong', 'Dinh_Ngoc_Diep', 'Dong_Nhi', 'Don_Nguyen',
              'Elly_Tran', 'Giang_Hong_Ngoc', 'Gin_Tuan_Kiet', 'Ha_Anh_Tuan', 'Han_Sara',
              'Hariwon', 'Hien_Ho', 'Hoai_Linh', 'Hoa_MinZy', 'Hoang_Thuy_Linh',
              'Hoang_Yen_Chipi', 'Ho_Ngoc_Ha', 'Ho_Quang_Hieu', 'Ho_Viet_Trung', 'Huong_Tram',
              'Huynh_Lap', 'Huy_Tran', 'Isaac', 'JangMi', 'Jun_Vu'
             ]

class LocalBinaryPatterns(object):
    def __init__(self, numPoints, radius):
        self.numPoints = numPoints
        self.radius = radius

    def resizeImage(self, image):
        (h, w) = image.shape[:2]

        width = 360  
        ratio = width / float(w)
        dim = (width, int(h * ratio))

        resized = cv2.resize(image, dim, interpolation=cv2.INTER_AREA)

        return resized

    def describe(self, img_name, eps=1e-7):
        image = cv2.imread(img_name)
        image_gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        image_lbp = feature.local_binary_pattern(image_gray, self.numPoints, self.radius, method= "uniform" )
        (hist, _) = np.histogram(image_lbp.ravel() , bins=256, range=(0, 256))

        return hist

    def extractHistogramList(self, dir):
        histogramList = []
        labelList = []

        index = 0
        for categori in categories:
            index += 1
            path = os.path.join(dir, categori)
            os.chdir(path)

            for img_name in os.listdir(path):
                hist = self.describe(img_name)
                histogramList.append(hist)
                labelList.append(index)

        return histogramList, labelList

if __name__=="__main__":
    lbp = LocalBinaryPatterns(n_points, radius)
    train_data_list, train_labels_list = lbp.extractHistogramList(dir_train)
    #model = LinearSVC(C=1000.0, random_state=42)
    model = SVC(kernel='linear', probability=True)
    model.fit(train_data_list, train_labels_list)

    os.chdir(dir_model)

    joblib.dump(model, "model.pkl")

    model = joblib.load("model.pkl")

    test_data_list, test_labels_list = lbp.extractHistogramList(dir_test)
    predictionList = model.predict(test_data_list)
    print("Accuracy: ", metrics.accuracy_score(test_labels_list, predictionList))
    print("F1 Score:", metrics.f1_score(test_labels_list, predictionList, average='micro'))

    print(predictionList)