(in-package #:sealable-metaobjects-test-suite)

(defun generic-+ (&rest things)
  (cond ((null things) 0)
        ((null (rest things)) (first things))
        (t (reduce #'generic-binary-+ things))))

(define-compiler-macro generic-+ (&rest things)
  (cond ((null things) 0)
        ((null (rest things)) (first things))
        (t
         (flet ((symbolic-generic-binary-+ (a b)
                  `(generic-binary-+ ,a ,b)))
           (reduce #'symbolic-generic-binary-+ things)))))

(defun generic-* (&rest things)
  (cond ((null things) 0)
        ((null (rest things)) (first things))
        (t (reduce #'generic-binary-+ things))))

(define-compiler-macro generic-* (&rest things)
  (cond ((null things) 1)
        ((null (rest things)) (first things))
        (t
         (flet ((symbolic-generic-binary-* (a b)
                  `(generic-binary-* ,a ,b)))
           (reduce #'symbolic-generic-binary-* things)))))

(defun generic-+-user (x y z)
  (declare (single-float x y z))
  (generic-+ x y z))

(defun generic-*-user (x y z)
  (declare (single-float x y z))
  (generic-* x y z))

(defun rest-args-user (x y z)
  (declare (single-float x y z))
  (rest-args x y z z z))
