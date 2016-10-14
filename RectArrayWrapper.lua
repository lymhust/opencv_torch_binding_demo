cv = require 'cv'
require 'cv.objdetect'
ffi = require 'ffi'
C = ffi.load(cv.libPath('Common'))

function cv.TensorToRectArray(tbl)
    local result = ffi.new('struct RectArray')
    result.size = tbl:size(1)
    result.data = ffi.gc(
        C.malloc(result.size * ffi.sizeof('struct RectWrapper')),
        C.free)
    for i = 1, result.size  do
        result.data[i-1].x = tbl[i][1]
		result.data[i-1].y = tbl[i][2]
		result.data[i-1].width = tbl[i][3]
		result.data[i-1].height = tbl[i][4]
    end
	return result
end

aa = torch.FloatTensor{{1,2,3,4},{5,6,7,8}}

bb = cv.TensorToRectArray(aa)
print(bb.data[1].height)

bb = cv.groupRectangles{bb,0.2,0.2}

print(bb)
