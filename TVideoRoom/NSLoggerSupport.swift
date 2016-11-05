//
//  NSLoggerSupport.swift
//  TVideoRoom

import NSLogger



private func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
	switch (lhs, rhs) {
	case let (l?, r?):
		return l < r
	case (nil, _?):
		return true
	default:
		return false
	}
}

private func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
	switch (lhs, rhs) {
	case let (l?, r?):
		return l >= r
	default:
		return !(lhs < rhs)
	}
}

var soketQuque = DispatchQueue(label: "socket", attributes: DispatchQueue.Attributes.concurrent);

func LogSocket(_ format: String!) {
	#if DEBUG
		LogMessage_va("socket", 3, format, getVaList([]))
	#endif
}

func LogSocket(_ format: String!, args: CVarArg...) {
	#if DEBUG
		LogMessage_va("socket", 3, format, getVaList(args))
	#endif
}

func LogHttp(_ format: String!) {
	#if DEBUG
		LogMessage_va("Http", 3, format, getVaList([]))
	#endif
}

func LogHttp(_ format: String!, args: CVarArg...) {
	#if DEBUG
		LogMessage_va("Http", 3, format, getVaList(args))
	#endif
}
func LogMessageT(_ domain: String!, level: Int32, format: String!, args: CVarArg...) {
	LogMessage_va(domain, level, format, getVaList(args))
}

func LogMessageF(_ filename: UnsafePointer<Int8>, lineNumber: Int32, functionName: UnsafePointer<Int8>, domain: String!, level: Int32, format: String!, args: CVarArg...) {
	LogMessageF_va(filename, lineNumber, functionName, domain, level, format, getVaList(args))
}

func LogMessageTo(_ logger: OpaquePointer, domain: String!, level: Int32, format: String!, args: CVarArg...) {
	LogMessageTo_va(logger, domain, level, format, getVaList(args))
}

func LogMessageToF(_ logger: OpaquePointer, filename: UnsafePointer<Int8>, lineNumber: Int32, functionName: UnsafePointer<Int8>, domain: String!, level: Int32, format: String!, args: CVarArg...) {
	LogMessageToF_va(logger, filename, lineNumber, functionName, domain, level, format, getVaList(args))
}

extension String {

	func toBase64() -> String {

		let data = self.data(using: String.Encoding.utf8)
		return data!.base64EncodedString();

	}

	func replace(target: String, withString: String) -> String
	{
		return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
	}

	subscript (_ r: Range<Int>) -> String {

		get {
			let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound);
			let endIndex = self.index(self.startIndex, offsetBy: r.upperBound);
			return self[Range(uncheckedBounds: (lower: startIndex, upper: endIndex))]
		}
	}

	func substring(_ s: Int, _ e: Int? = nil) -> String {

		let start = s >= 0 ? self.index(self.startIndex, offsetBy: s) : self.index(self.endIndex, offsetBy: s);

		let end = e == nil ? self.endIndex : (e >= 0 ? self.index(self.startIndex, offsetBy: e!) : self.index(self.endIndex, offsetBy: e!))

		// let index1: Int = self.distance(from: self.startIndex, to: start);
		// var index2: Int = self.distance(from: self.startIndex, to: end );
		var dim: Int = self.distance(from: start, to: end);

		var range = dim > 0 ? Range<String.Index>(start..<end) : Range<String.Index>(end..<start);
		return self.substring(with: range);
	}
}
